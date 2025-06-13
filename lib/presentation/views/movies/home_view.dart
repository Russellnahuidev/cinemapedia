import 'package:cinamapedia/presentation/providers/providers.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) {
      return const FullScerenLoader();
    }

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlidesShowProvider);
    //final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(floating: true, title: CustomAppbar()),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // CustomAppbar(),
                MoviesSlideshow(movies: slideShowMovies),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Hoy',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: 'En cines',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),

                //* Ya no estará aquí, ahora es parte del menú inferior
                // MovieHorizontalListview(
                //   movies: popularMovies,
                //   title: 'Populares',
                //   subTitle: 'Hoy',
                //   loadNextPage: () =>
                //       ref.read(popularMoviesProvider.notifier).loadNextPage(),
                // ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejores calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

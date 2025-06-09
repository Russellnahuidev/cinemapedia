import 'package:cinamapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinamapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.movie_outlined, color: colors.primary),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              const Spacer(),
              Text('CinaMapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality
                  final movieRepository = ref.read(movieRespositoryProvider);

                  showSearch(
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMoviesCallback: movieRepository.searchMovies,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

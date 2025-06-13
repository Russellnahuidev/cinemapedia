import 'package:animate_do/animate_do.dart';
import 'package:cinamapedia/config/helpers/human_formats.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinamapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadAtors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndOverview(movie: movie, size: size, textStyles: textStyles),
        //Generos de la película
        _Generes(movie: movie),

        //* Actores de la pelicula
        ActorsByMovie(movieId: movie.id.toString()),
        SizedBox(height: 50),

        //* Peliculas similares
        VideosFromMovie(movieId: movie.id),
      ],
    );
  }
}

class _Generes extends StatelessWidget {
  const _Generes({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          // spacing: 8,
          // runSpacing: 4,
          children: [
            ...movie.genreIds.map(
              (gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          //Descripción
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleLarge),
                Text(movie.overview, style: textStyles.bodyMedium),

                SizedBox(height: 10),

                MovieRating(voteAverage: movie.voteAverage),

                Row(
                  children: [
                    Text(
                      'Estreno:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final isFavoriteProvier = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStoregeRepository = ref.watch(localStoregeRepositoryProvider);
  return localStoregeRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvier(movie.id));
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            //  ref
            //     .read(localStoregeRepositoryProvider)
            //     .toggleFavorite(movie);

            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);

            ref.invalidate(isFavoriteProvier(movie.id));
          },
          icon: isFavoriteFuture.when(
            loading: () => CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? Icon(Icons.favorite_rounded, color: Colors.red)
                : Icon(Icons.favorite_border),
            error: (error, stackTrace) => Icon(Icons.error),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 0),
        title: _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),

            _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.center,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

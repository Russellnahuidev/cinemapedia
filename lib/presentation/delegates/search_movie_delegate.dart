import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinamapedia/config/helpers/human_formats.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMoviesCallback;
  List<Movie> initialMovies;

  StreamController<List<Movie>> deboncedMoviesController =
      StreamController.broadcast();
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMoviesCallback,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar películas');

  void clearStrams() {
    deboncedMoviesController.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMoviesCallback(query);
      initialMovies = movies;
      deboncedMoviesController.add(movies);
      isLoadingStream.add(false);
    });
  }

  Widget builResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: deboncedMoviesController.stream,

      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStrams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  // @override
  // String get searchFieldLabel => 'Buscar Películas';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: Duration(seconds: 10),
              spins: 10,
              infinite: true,
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  query = '';
                },
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
              },
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        clearStrams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results logic here
    return builResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return builResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              //Image
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/loaders/bottle-loader.gif'),
                    image: NetworkImage(movie.posterPath),
                  ),
                ),
              ),
              SizedBox(width: 10),

              //Description
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: titleStyle.titleMedium),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          HumanFormats.number(movie.voteAverage, 1),
                          style: titleStyle.bodyMedium!.copyWith(
                            color: Colors.yellow.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

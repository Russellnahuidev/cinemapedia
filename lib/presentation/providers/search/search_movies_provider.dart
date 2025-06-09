import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchqueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.read(movieRespositoryProvider);

      return SearchedMoviesNotifier(
        ref: ref,
        searchMoviesCallback: movieRepository.searchMovies,
      );
    });

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;
  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMoviesCallback,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMoviesCallback(query);
    ref.read(searchqueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}

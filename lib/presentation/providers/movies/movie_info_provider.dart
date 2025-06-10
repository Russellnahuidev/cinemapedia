import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieInfoProvider, Map<String, Movie>>((ref) {
      final movieRepository = ref.watch(movieRespositoryProvider);
      return MovieInfoProvider(getMovie: movieRepository.getMovieById);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieid);

class MovieInfoProvider extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieInfoProvider({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}

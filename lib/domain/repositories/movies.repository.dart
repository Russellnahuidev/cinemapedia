import 'package:cinamapedia/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  // Future<Movie> getMovieById(int id);
  // Future<List<Movie>> searchMovies(String query);
  // Future<List<Movie>> getPopularMovies();
  // Future<List<Movie>> getTopRatedMovies();
  // Future<List<Movie>> getUpcomingMovies();
}

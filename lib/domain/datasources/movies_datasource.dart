import 'package:cinamapedia/domain/entities/entities.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<Movie> getMovieById(String id);
  // Future<List<Movie>> searchMovies(String query);
  // Future<Movie> getMovieById(int id);
  Future<List<Movie>> searchMovies(String query);
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> getUpcomingMovies({int page = 1});
  Future<List<Movie>> getSimilarMovies(int movieId);
  Future<List<Video>> getYoutubeVideosById(int movieId);
}

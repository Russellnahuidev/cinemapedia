import 'package:cinamapedia/domain/entities/movie.dart';

abstract class LocalStoregeRepository {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}

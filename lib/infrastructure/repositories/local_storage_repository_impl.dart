import 'package:cinamapedia/domain/datasources/local_storage_datasurce.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/domain/repositories/local_storege_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl(this.dataSource);
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }
}

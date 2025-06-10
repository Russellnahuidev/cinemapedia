import 'package:cinamapedia/domain/datasources/local_storage_datasurce.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatasourceImpl extends LocalStorageDataSource {
  IsarDatasourceImpl() {
    db = openDB();
  }

  late Future<Isar> db;

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true, directory: '');
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool?> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movieId)
        .findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst();
    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}

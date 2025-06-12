import 'package:cinamapedia/domain/datasources/local_storage_datasurce.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasourceImpl extends LocalStorageDataSource {
  IsarDatasourceImpl() {
    db = openDB();
  }

  late Future<Isar> db;

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
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

  // @override
  // Future<void> toggleFavorite(Movie movie) async {
  //   final isar = await db;
  //   final favoriteMovie = await isar.movies
  //       .filter()
  //       .idEqualTo(movie.id)
  //       .findFirst();
  //   if (favoriteMovie != null) {
  //     isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
  //   }
  //   isar.writeTxnSync(() => isar.movies.putSync(movie));
  // }
  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst();

    if (favoriteMovie != null) {
      // Si existe, la eliminamos (ya no es favorita)
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    } else {
      // Si no existe, la agregamos (ahora es favorita)
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}

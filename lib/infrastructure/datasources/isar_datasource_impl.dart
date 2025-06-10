import 'package:cinamapedia/domain/datasources/local_storage_datasurce.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatasourceImpl extends LocalStorageDataSource {
  IsarDatasourceImpl() {
    db = openDB();
  }

  late Future<Isar> db;

  @override
  Future<bool?> isMovieFavorite(int movieId) {
    // TODO: implement isMocieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true, directory: '');
    }
    return Future.value(Isar.getInstance());
  }
}

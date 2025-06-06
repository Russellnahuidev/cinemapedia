import 'package:cinamapedia/config/constants/environment.dart';
import 'package:cinamapedia/domain/datasources/movies_datasource.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class ThemoviedbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    final List<Movie> movies = [];
    return movies;
  }
}

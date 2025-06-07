import 'package:cinamapedia/config/constants/environment.dart';
import 'package:cinamapedia/domain/datasources/movies_datasource.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinamapedia/infrastructure/models/moviedb/moviedeb_response.dart';
import 'package:dio/dio.dart';

class ThemoviedbDatasourceImpl extends MoviesDataSource {
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
    final response = await dio.get('/movie/now_playing');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.movieDBToEntity(movieDB))
        .toList();
    return movies;
  }
}

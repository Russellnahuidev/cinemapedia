import 'package:cinamapedia/domain/datasources/movies_datasource.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource moviesDataSource;
  MovieRepositoryImpl(this.moviesDataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return moviesDataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    return moviesDataSource.getTopRatedMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) {
    return moviesDataSource.getUpcomingMovies(page: page);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return moviesDataSource.searchMovies(query);
  }
}

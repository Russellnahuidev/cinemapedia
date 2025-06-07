import 'package:cinamapedia/infrastructure/datasources/themoviedb_datasource_impl.dart';
import 'package:cinamapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable
final movieRespositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(ThemoviedbDatasourceImpl());
});

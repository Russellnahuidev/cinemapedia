import 'package:cinamapedia/infrastructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:cinamapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable
final actorsRespistoyProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMoviedbDatasourceImpl());
});

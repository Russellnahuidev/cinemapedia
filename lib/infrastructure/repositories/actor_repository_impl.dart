import 'package:cinamapedia/domain/datasources/actors_datasource.dart';
import 'package:cinamapedia/domain/entities/actor.dart';
import 'package:cinamapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDataSource actorsDataSource;

  ActorRepositoryImpl(this.actorsDataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDataSource.getActorsByMovie(movieId);
  }
}

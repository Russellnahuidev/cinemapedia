import 'package:cinamapedia/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
  // Future<Actor> getActorById(String id);
  // Future<List<Actor>> searchActors(String query);
  // Future<List<Actor>> getPopularActors({int page = 1});
  // Future<List<Actor>> getTopRatedActors({int page = 1});
  // Future<List<Actor>> getUpcomingActors({int page = 1});
}

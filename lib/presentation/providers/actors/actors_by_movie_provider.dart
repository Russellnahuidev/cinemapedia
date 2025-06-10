import 'package:cinamapedia/domain/entities/actor.dart';
import 'package:cinamapedia/presentation/providers/actors/actors_repository_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>((ref) {
      final actorsRepository = ref.watch(actorsRespistoyProvider);
      return ActorsByMovieProvider(getActors: actorsRepository.getActorsByMovie);
    });

typedef GetActorsCallback = Future<List<Actor>> Function(String movieid);

class ActorsByMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieProvider({required this.getActors}) : super({});

  Future<void> loadAtors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}

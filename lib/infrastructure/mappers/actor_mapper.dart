import 'package:cinamapedia/domain/entities/actor.dart';
import 'package:cinamapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    character: cast.character,
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
  );
}

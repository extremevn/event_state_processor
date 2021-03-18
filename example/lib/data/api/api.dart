import 'package:example_event_state_processor/domain/pojo/pokemon.dart';

const webApiBaseUrl = "https://pokeapi.co/api/v2";

abstract class Api {

  Future<List<Pokemon>> getPokemons(int offset, int limit);

}

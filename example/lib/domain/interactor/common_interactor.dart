import 'package:example_event_state_processor/data/data.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';

class CommonInteractor {
  final  numberPokemonLimit = 10;

  Future<List<Pokemon>> getPokemons(int page) async {
    return api.getPokemons(page * numberPokemonLimit, numberPokemonLimit);
  }


}

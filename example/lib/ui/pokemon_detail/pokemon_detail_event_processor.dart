import 'dart:async';

import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_event.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_state.dart';


class PokemonDetailEventProcessor extends EventToStateProcessor<PokemonDetailEvent, PokemonDetailState> {

  @override
  PokemonDetailState get initialState => const PokemonDetailState(isInit: true, isLoading: false);

  @override
  Stream<PokemonDetailState> processEvent(PokemonDetailEvent event) async* {

  }
}

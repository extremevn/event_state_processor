import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_event.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_event_processor.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_state.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/pokemon_detail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PokemonDetailScreen extends CoreScreen<PokemonDetailEvent,
    PokemonDetailState, PokemonDetailEventProcessor> {
  final Pokemon pokemonDetail;

  PokemonDetailScreen(this.pokemonDetail);

  @override
  PokemonDetailEventProcessor createEventProcessor(BuildContext context) {
    return PokemonDetailEventProcessor();
  }

  @override
  Widget buildScreenUi(BuildContext context) {
    return PokemonDetail(pokemonDetail);
  }
}

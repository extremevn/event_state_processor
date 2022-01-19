import 'dart:async';
import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/data/api/api_exception.dart';
import 'package:example_event_state_processor/domain/domain.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/home_screen/home_event.dart';
import 'package:example_event_state_processor/ui/home_screen/home_state.dart';

class HomeEventProcessor
    extends EventToStateProcessor<HomeEvent, HomeDataState> {

  HomeEventProcessor()
      : super(const HomeDataState(
            isInit: true, isLoading: false, pokemons: [], currentPage: 0));

  @override
  Stream<HomeDataState> processEvent(HomeEvent event) async* {
    if (event is LoadDataEvent) {
      try {
        yield state.copy(isInit: false, isLoading: true);
        final dataPokemon = await commonInteractor.getPokemons(event.page);
        final data = <Pokemon>[];
        if (state.pokemons != null && state.pokemons!.isNotEmpty) {
          data.addAll(state.pokemons!);
        }
        data.addAll(dataPokemon);
        yield state.copy(
            isLoading: false, dataPokemon: data, currentPage: event.page);
      } catch (error) {
        yield state.copy(isLoading: false, error: error as ApiException);
      }
    }
  }
}

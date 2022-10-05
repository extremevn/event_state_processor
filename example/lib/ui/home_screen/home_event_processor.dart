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
            isInit: true, isLoading: false, pokemons: [], currentPage: 0)) {
    on<LoadDataEvent>(onLoadDataEvent);
  }

  FutureOr<void> onLoadDataEvent(
      LoadDataEvent event, Emitter<HomeDataState> emitter) async {
    emitter.call(state.copy(isInit: false, isLoading: true));
    final dataPokemon = await commonInteractor.getPokemons(event.page);
    final data = <Pokemon>[];
    if (state.pokemons != null && state.pokemons!.isNotEmpty) {
      data.addAll(state.pokemons!);
    }
    data.addAll(dataPokemon);
    emitter.call(state.copy(
        isLoading: false, dataPokemon: data, currentPage: event.page));
  }

  @override
  void onCatchException(
      dynamic exceptionOrError, Emitter<HomeDataState> emitter) {
    emitter.call(
        state.copy(isLoading: false, error: exceptionOrError as ApiException));
  }
}

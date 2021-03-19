import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/data/api/api_exception.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';

class HomeDataState extends DataState {
  final bool isInit;
  final bool isLoading;
  final ApiException error;
  final List<Pokemon> pokemons;
  final int currentPage;

  const HomeDataState(
      {this.isInit,
      this.isLoading,
      this.error,
      this.pokemons,
      this.currentPage});

  HomeDataState copy(
      {bool isInit,
      bool isLoading,
      ApiException error,
      List<Pokemon> dataPokemon,
      int currentPage}) {
    return HomeDataState(
        isInit: isInit ?? this.isInit,
        isLoading: isLoading ?? this.isLoading,
        pokemons: dataPokemon ?? pokemons,
        currentPage: currentPage ?? this.currentPage,
        error: error);
  }

  List<Pokemon> mergeWith(List<Pokemon> dataPokemon) {
    return pokemons == null || pokemons.isEmpty ? dataPokemon : pokemons
      ..addAll(dataPokemon);
  }
}

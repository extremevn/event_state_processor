import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/fade_page_route.dart';
import 'package:example_event_state_processor/ui/home_screen/home_event.dart';
import 'package:example_event_state_processor/ui/home_screen/home_event_processor.dart';
import 'package:example_event_state_processor/ui/home_screen/home_state.dart';
import 'package:example_event_state_processor/ui/home_screen/widget/pokemon_grid.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/pokemon_detail_screen.dart';
import 'package:example_event_state_processor/ui/view_common/loading_indicator_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen
    extends CoreScreen<HomeEvent, HomeDataState, HomeEventProcessor> {
  @override
  void handleDataStateChange(BuildContext context, HomeEventProcessor processor,
      HomeDataState state) {}

  @override
  HomeEventProcessor createEventProcessor(BuildContext context) {
    return HomeEventProcessor();
  }

  @override
  Widget buildScreenUi(
      BuildContext context, HomeEventProcessor processor, HomeDataState state) {
    if (state.isInit) {
      processor.raiseEvent(const LoadDataEvent(page: 0));
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F0E8),
      body: SafeArea(
        child: Stack(
          children: [
            _mainContentWidget(context, processor, state),
            if (state.isLoading) LoadingIndicatorWidget(),
          ],
        ),
      ),
    );
  }

  Widget _mainContentWidget(
      BuildContext context, HomeEventProcessor processor, HomeDataState state) {
    return PokemonGrid(
      pokemons: state.pokemons ?? <Pokemon>[],
      canLoadMore: state.currentPage < 1,
      onRefresh: () async {
        debugPrint('onRefresh data');
      },
      onSelectPokemon: (index, pokemon) {
        Navigator.of(context)
            .push(FadeRoute(page: PokemonDetailScreen(pokemon)));
      },
    );
  }
}

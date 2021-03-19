import 'package:example_event_state_processor/configs/colors.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/app/translation.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/tab_about.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/tab_base_stats.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/tab_evolution.dart';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class TabData {
  const TabData({
    this.label,
    this.builder,
  });

  final Widget Function(Pokemon pokemon, Animation animation) builder;
  final String label;
}

class PokemonTabInfo extends StatelessWidget {
  final Animation _animation;
  final Pokemon pokemon;
  const PokemonTabInfo(this._animation, this.pokemon);

  Widget _buildTabBar(BuildContext context, List<TabData> tabs) {
    return TabBar(
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.grey,
      labelPadding: EdgeInsets.symmetric(
        vertical: context.responsive(16),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: AppColors.indigo,
      tabs: tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent(List<TabData> tabs) {
    return Expanded(
        child: TabBarView(
      children: tabs.map((tab) => tab.builder(pokemon, _animation)).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;
    final tabs = <TabData>[
      TabData(
        label: Translations.of(context).text('tab_about'),
        builder: (pokemon, animation) => PokemonAbout(pokemon, animation),
      ),
      TabData(
        label: Translations.of(context).text('tab_stats'),
        builder: (pokemon, animation) =>
            PokemonBaseStats(pokemon, animation as Animation<double>),
      ),
      TabData(
        label: Translations.of(context).text('tab_evolution'),
        builder: (pokemon, animation) => PokemonEvolution(pokemon, animation),
      ),
    ];
    return DefaultTabController(
      length: 3,
      child: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) => SizedBox(
                  height: context
                      .responsive((1 - (_animation.value as double)) * 16 + 6)),
            ),
            _buildTabBar(context, tabs),
            _buildTabContent(tabs),
          ],
        ),
      ),
    );
  }
}

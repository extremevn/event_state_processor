import 'package:example_event_state_processor/configs/colors.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon_types.dart';
import 'package:example_event_state_processor/extensions/context.dart';
import 'package:example_event_state_processor/ui/app/translation.dart';
import 'package:example_event_state_processor/ui/home_screen/widget/pokemon_type.dart';
import 'package:example_event_state_processor/ui/view_common/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Stat extends StatelessWidget {
  const Stat({
    @required this.animation,
    @required this.label,
    @required this.value,
    this.progress,
  });

  final Animation animation;
  final String label;
  final double progress;
  final num value;

  @override
  Widget build(BuildContext context) {
    final double currentProgress = progress ?? value / 100;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * currentProgress as double,
              color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
            ),
          ),
        ),
      ],
    );
  }
}

class PokemonBaseStats extends StatefulWidget {
  final Pokemon pokemon;
  final Animation<double> scrollAnimation;

  const PokemonBaseStats(this.pokemon, this.scrollAnimation);

  @override
  _PokemonBaseStatsState createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<PokemonBaseStats> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  Pokemon get pokemon => widget.pokemon;

  Animation<double> get scrollAnimation => widget.scrollAnimation;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  List<Widget> generateStatWidget(BuildContext context) {
    return [
      Stat(animation: _animation, label: Translations.of(context).text('hp'), value: pokemon.hp),
      SizedBox(height: context.responsive(14)),
      Stat(animation: _animation, label: Translations.of(context).text('attack'), value: pokemon.attack),
      SizedBox(height: context.responsive(14)),
      Stat(animation: _animation, label: Translations.of(context).text('defense'), value: pokemon.defense),
      SizedBox(height: context.responsive(14)),
      Stat(animation: _animation, label: Translations.of(context).text('sp_atk'), value: pokemon.specialAttack),
      SizedBox(height: context.responsive(14)),
      Stat(animation: _animation, label: Translations.of(context).text('sp_def'), value: pokemon.specialDefense),
      SizedBox(height: context.responsive(14)),
      Stat(animation: _animation, label: Translations.of(context).text('speed'), value: pokemon.speed),
      SizedBox(height: context.responsive(14)),
      Stat(
        animation: _animation,
        label: Translations.of(context).text('total'),
        value: 100,
        progress: 100 / 600,
      ),
    ];
  }

  List<Widget> _buildEffectivenesses(BuildContext context) {
    final list = pokemon.types
        .map((type) => PokemonType(PokemonTypesX.parse(type ?? ""), large: true, colored: true, extra: Translations.of(context).text('extra')))
        .toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollAnimation,
      builder: (context, child) {
        final scrollable = scrollAnimation.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(24),
            horizontal: 24,
          ),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...generateStatWidget(context),
          SizedBox(height: context.responsive(27)),
          Text(
            Translations.of(context).text('type_defenses'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 0.8,
            ),
          ),
          SizedBox(height: context.responsive(15)),
          Text(
            Translations.of(context).textWithArgs('poke_stats', {"pokemon_name": pokemon.name}),
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
          SizedBox(height: context.responsive(15)),
          Wrap(
            spacing: context.responsive(8),
            runSpacing: context.responsive(8),
            children: _buildEffectivenesses(context),
          ),
        ],
      ),
    );
  }
}

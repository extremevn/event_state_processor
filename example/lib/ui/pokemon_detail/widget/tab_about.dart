import 'package:example_event_state_processor/configs/colors.dart';
import 'package:example_event_state_processor/configs/images.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/app/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class PokemonAbout extends StatelessWidget {
  const PokemonAbout(this._pokemon, this._animation);

  final Pokemon _pokemon;
  final Animation _animation;

  Widget _buildSection(BuildContext context, String text, {List<Widget> children, Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            height: 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.responsive(22)),
        if (child != null) child,
        if (children != null) ...children
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.black.withOpacity(0.6),
        height: 0.8,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      _pokemon.xDescription,
      style: const TextStyle(height: 1.3),
    );
  }

  Widget _buildHeightWeight(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: context.responsive(16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, context.responsive(8)),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildLabel(Translations.of(context).text('height')),
                SizedBox(height: context.responsive(11)),
                Text(_pokemon.height, style: const TextStyle(height: 0.8))
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildLabel(Translations.of(context).text('weight')),
                SizedBox(height: context.responsive(11)),
                Text(_pokemon.weight, style: const TextStyle(height: 0.8))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreeding(BuildContext context) {
    return _buildSection(context, Translations.of(context).text('breeding'), children: [
      Row(
        children: <Widget>[
          Expanded(child: _buildLabel(Translations.of(context).text('gender'))),
          if (_pokemon.genderless == 0) ...[
            Expanded(
              child: Row(
                children: <Widget>[
                  const Image(image: AppImages.male, width: 12, height: 12),
                  const SizedBox(width: 4),
                  Text(_pokemon.genderMalePercentage, style: const TextStyle(height: 0.8)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  const Image(image: AppImages.female, width: 12, height: 12),
                  const SizedBox(width: 4),
                  Text(_pokemon.genderFemalePercentage, style: const TextStyle(height: 0.8)),
                ],
              ),
            ),
          ] else
            Expanded(
              flex: 3,
              child: Text(
                Translations.of(context).text('genderless'),
                style: const TextStyle(height: 0.8),
              ),
            ),
        ],
      ),
      SizedBox(height: context.responsive(18)),
      Row(
        children: <Widget>[
          Expanded(child: _buildLabel(Translations.of(context).text('egg_groups'))),
          Expanded(
            flex: 2,
            child: Text(
              _pokemon.eggGroups,
              style: const TextStyle(height: 0.8),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      SizedBox(height: context.responsive(18)),
      Row(
        children: <Widget>[
          Expanded(
            child: _buildLabel(Translations.of(context).text('egg_cycle')),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _pokemon.eggGroups,
              style: const TextStyle(height: 0.8),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    ]);
  }

  Widget _buildLocation(BuildContext context) {
    return _buildSection(
      context,
      Translations.of(context).text('location'),
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.teal,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildTraining(BuildContext context) {
    return _buildSection(
      context,
      Translations.of(context).text('training'),
      child: Row(
        children: <Widget>[
          Expanded(child: _buildLabel(Translations.of(context).text('base_exp'))),
          Expanded(flex: 3, child: Text(_pokemon.baseExp)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final scrollable = _animation.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(19),
            horizontal: 27,
          ),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          _buildDescription(),
          SizedBox(height: context.responsive(28)),
          _buildHeightWeight(context),
          SizedBox(height: context.responsive(31)),
          _buildBreeding(context),
          SizedBox(height: context.responsive(35)),
          _buildLocation(context),
          SizedBox(height: context.responsive(26)),
          _buildTraining(context),
        ],
      ),
    );
  }
}

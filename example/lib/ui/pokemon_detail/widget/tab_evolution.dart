import 'package:cached_network_image/cached_network_image.dart';
import 'package:example_event_state_processor/configs/colors.dart';
import 'package:example_event_state_processor/configs/images.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/app/translation.dart';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class PokemonBall extends StatelessWidget {
  const PokemonBall(this.pokemon);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height;
    final pokeballSize = screenHeight * 0.1;
    final pokemonSize = pokeballSize * 0.85;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: AppColors.lightGrey,
            ),
            CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              imageBuilder: (_, image) => Image(
                image: image,
                width: pokemonSize,
                height: pokemonSize,
              ),
            )
          ],
        ),
        SizedBox(height: context.responsive(3)),
        Text(pokemon.name),
      ],
    );
  }
}

class PokemonEvolution extends StatefulWidget {
  final Animation animation;
  final Pokemon pokemon;

  const PokemonEvolution(this.pokemon, this.animation);

  @override
  _PokemonEvolutionState createState() => _PokemonEvolutionState();
}

class _PokemonEvolutionState extends State<PokemonEvolution> {
  Widget _buildRow({Pokemon current, Pokemon next, String reason}) {
    return Row(
      children: <Widget>[
        Expanded(child: PokemonBall(current)),
        Expanded(
          child: Column(
            children: <Widget>[
              const Icon(Icons.arrow_forward, color: AppColors.lightGrey),
              SizedBox(height: context.responsive(7)),
              Text(
                reason,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(child: PokemonBall(next)),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        SizedBox(height: context.responsive(21)),
        const Divider(),
        SizedBox(height: context.responsive(21)),
      ],
    );
  }

  List<Widget> buildEvolutionList(List<Pokemon> pokemons) {
    return Iterable<int>.generate(pokemons.length - 1) // skip the last one
        .map(
          (index) => _buildRow(
            current: pokemons[index],
            next: pokemons[index + 1],
            reason: pokemons[index + 1].reason,
          ),
        )
        .expand((widget) => [widget, _buildDivider()])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        final scrollable = widget.animation.value.floor() == 1;

        return SingleChildScrollView(
          physics: scrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(31),
            horizontal: 28,
          ),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Translations.of(context).text('evolution_chain'),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
          ),
          SizedBox(height: context.responsive(28)),
          ...buildEvolutionList([widget.pokemon, widget.pokemon]),
        ],
      ),
    );
  }
}

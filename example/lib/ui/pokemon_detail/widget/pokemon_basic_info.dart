import 'package:cached_network_image/cached_network_image.dart';
import 'package:example_event_state_processor/configs/images.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon_types.dart';
import 'package:example_event_state_processor/ui/home_screen/widget/pokemon_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class PokemonOverallInfo extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonOverallInfo(this.pokemon);

  @override
  _PokemonOverallInfoState createState() => _PokemonOverallInfoState();
}

class _PokemonOverallInfoState extends State<PokemonOverallInfo>
    with TickerProviderStateMixin {
  Pokemon get pokemon => widget.pokemon;

  AnimationController _rotateController;

  @override
  void initState() {
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _rotateController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _rotateController.dispose();

    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(pokemon.name),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        icon: const Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }

  Widget _buildPokemonName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pokemon.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 36,
            ),
          ),
          Text(
            pokemon.id,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonTypes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Wrap(
              spacing: context.responsive(8),
              runSpacing: context.responsive(8),
              children: pokemon.types
                  .map((type) => PokemonType(PokemonTypesX.parse(type)))
                  .toList(),
            ),
          ),
          Text(
            pokemon.category,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonSlider() {
    final screenSize = context.screenSize;
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.24,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: RotationTransition(
              turns: _rotateController,
              child: Image(
                image: AppImages.pokeball,
                width: screenSize.height * 0.24,
                height: screenSize.height * 0.24,
                color: Colors.white.withOpacity(0.14),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                imageBuilder: (context, image) => Image(
                  image: image,
                  width: screenSize.height * 0.22,
                  height: screenSize.height * 0.22,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        SizedBox(height: context.responsive(9)),
        _buildPokemonName(),
        SizedBox(height: context.responsive(9)),
        _buildPokemonTypes(),
        SizedBox(height: context.responsive(25)),
        _buildPokemonSlider(),
      ],
    );
  }
}

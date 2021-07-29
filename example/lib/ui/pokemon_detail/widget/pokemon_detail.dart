import 'package:example_event_state_processor/configs/images.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/animated_fade.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/decoration_box.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/pokemon_basic_info.dart';
import 'package:example_event_state_processor/ui/pokemon_detail/widget/tab.dart';
import 'package:example_event_state_processor/ui/util.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail(this.pokemon);

  final Pokemon pokemon;

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail>
    with TickerProviderStateMixin {
  static const double _pokemonSlideOverflow = 20;

  final GlobalKey _pokemonInfoKey = GlobalKey();

  double _cardMinHeight = 0.0;
  double _cardMaxHeight = 0.0;
  late AnimationController _cardController;
  late AnimationController _cardHeightController;
  late AnimationController _rotateController;

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _cardHeightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _rotateController.repeat();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final screenHeight = context.screenSize.height;
      final appBarHeight = AppBar().preferredSize.height;

      final pokemonInfoBox =
          _pokemonInfoKey.currentContext!.findRenderObject() as RenderBox;

      _cardMinHeight = screenHeight - pokemonInfoBox.size.height;
      _cardMaxHeight = screenHeight - appBarHeight - context.padding.top;

      _cardHeightController.forward();
    });

    super.initState();
  }

  Widget _buildBackground() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: parseColorPokemon(widget.pokemon.types.first));
  }

  Widget _buildBoxDecoration() {
    final screenSize = context.screenSize;

    return Positioned(
      top: -screenSize.height * 0.055,
      left: -screenSize.height * 0.055,
      child: DecorationBox(),
    );
  }

  Widget _buildDottedDecoration() {
    final screenSize = context.screenSize;

    return Positioned(
      top: context.responsive(4),
      left: screenSize.height * 0.3,
      child: AnimatedFade(
        animation: Tween(begin: 1.0, end: 0.0).animate(_cardController),
        child: Image(
          image: AppImages.dotted,
          width: screenSize.height * 0.07,
          height: screenSize.height * 0.07 * 0.54,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildAppBarPokeballDecoration() {
    final appBarHeight = AppBar().preferredSize.height;
    final screenSize = context.screenSize;
    final iconSize = context.iconSize ?? 24;

    final pokeSize = screenSize.width * 0.448;
    final pokeTop = -(pokeSize / 2 - (iconSize / 2 + appBarHeight));
    final pokeRight = -(pokeSize / 2 - (iconSize / 2 + 28));

    return Positioned(
      top: pokeTop,
      right: pokeRight,
      child: AnimatedFade(
        animation: _cardController,
        child: RotationTransition(
          turns: _rotateController,
          child: Image(
            image: AppImages.pokeball,
            width: pokeSize,
            height: pokeSize,
            color: Colors.white.withOpacity(0.26),
          ),
        ),
      ),
    );
  }

  Widget _buildPokemon() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        key: _pokemonInfoKey,
        child: PokemonOverallInfo(widget.pokemon),
      ),
    );
  }

  Widget _buildPokemonSlider() {
    return AnimatedBuilder(
      animation: _cardHeightController,
      builder: (_, child) {
        return SlidingUpPanel(
          minHeight: _cardMinHeight * _cardHeightController.value +
              _pokemonSlideOverflow,
          maxHeight: _cardMaxHeight,
          boxShadow: null,
          color: Colors.transparent,
          panel: child,
          onPanelSlide: (position) => _cardController.value = position,
        );
      },
      child: PokemonTabInfo(_cardController, widget.pokemon),
    );

    // return PokemonTabInfo(_cardController, widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        _buildBoxDecoration(),
        _buildDottedDecoration(),
        _buildAppBarPokeballDecoration(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              _buildPokemon(),
              _buildPokemonSlider(),
            ],
          ),
        ),
      ],
    );
  }
}

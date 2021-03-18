import 'package:example_event_state_processor/domain/pojo/pokemon_types.dart';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class PokemonType extends StatelessWidget {
  const PokemonType(
    this.type, {
    Key key,
    this.large = false,
    this.colored = false,
    this.extra = '',
  }) : super(key: key);

  final PokemonTypes type;
  final String extra;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: large ? 12 : 8,
      height: 0.8,
      fontWeight: large ? FontWeight.bold : FontWeight.normal,
      color: colored ? type.color : Colors.white,
    );
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 12,
          vertical: context.responsive(large ? 6 : 4),
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: (colored ? type.color : Colors.white).withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.value,
              textScaleFactor: 1,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 5),
            Text(
              extra,
              textScaleFactor: 1,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

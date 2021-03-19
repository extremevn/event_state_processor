import 'dart:math';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class DecorationBox extends StatelessWidget {
  static const double boxSizeFraction = 0.176;

  @override
  Widget build(BuildContext context) {
    final boxSize = context.screenSize.height * boxSizeFraction;

    return Transform.rotate(
      angle: pi * 5 / 12,
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0),
            ],
            begin: const Alignment(-0.2, -0.2),
            end: const Alignment(1.5, -0.3),
          ),
        ),
      ),
    );
  }
}

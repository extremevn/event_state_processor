import 'package:example_event_state_processor/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:example_event_state_processor/extensions/context.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    this.color = AppColors.red,
    @required this.progress,
  });

  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: color,
      ),
    );

    return Container(
        clipBehavior: Clip.hardEdge,
        height: context.responsive(3),
        alignment: Alignment.centerLeft,
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: AppColors.lighterGrey,
        ),
        child: FractionallySizedBox(
          widthFactor: progress,
          child: child,
        ));
  }
}

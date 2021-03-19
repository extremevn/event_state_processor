import 'package:example_event_state_processor/configs/colors.dart';
import 'package:flutter/material.dart';

import 'app/translation.dart';

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  if (hexString == null || hexString.isEmpty) return Colors.transparent;

  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

Size textSize(String text, TextStyle style) {
  final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout();
  return textPainter.size;
}

String cleanText(String inputStr) {
  return inputStr.trim();
}

bool checkEmpty(String inputStr) {
  return cleanText(inputStr).isEmpty;
}

String getErrorBasedOnErrorCode(BuildContext context, String errorCode) {
  return Translations.of(context).text('message_error_$errorCode');
}

void hiddenKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String cleanSpace(String text) {
  return text.replaceAll(' ', '');
}

void scrollToTop(ScrollController scrollController) {
  scrollController.animateTo(
    0.0,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 300),
  );
}

// ignore: type_annotate_public_apis
String getEnumValue(e) => e.toString().split('.').last;

Color parseColorPokemon(String typeFirst) {
  switch (typeFirst.toLowerCase()) {
    case 'grass':
      return AppColors.lightGreen;

    case 'bug':
      return AppColors.lightTeal;

    case 'fire':
      return AppColors.lightRed;

    case 'water':
      return AppColors.lightBlue;

    case 'fighting':
      return AppColors.red;

    case 'normal':
      return AppColors.beige;

    case 'electric':
      return AppColors.lightYellow;

    case 'psychic':
      return AppColors.lightPink;

    case 'poison':
      return AppColors.lightPurple;

    case 'ghost':
      return AppColors.purple;

    case 'ground':
      return AppColors.darkBrown;

    case 'rock':
      return AppColors.lightBrown;

    case 'dark':
      return AppColors.black;

    case 'dragon':
      return AppColors.violet;

    case 'fairy':
      return AppColors.pink;

    case 'flying':
      return AppColors.lilac;

    case 'ice':
      return AppColors.lightCyan;

    case 'steel':
      return AppColors.grey;

    default:
      return AppColors.lightBlue;
  }
}

extension StringX on String {
  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return this;
  }

  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }
}

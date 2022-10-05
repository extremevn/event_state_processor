import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(this.locale) {
    _localizedValues = null;
  }

  Locale locale;
  static Map<String, dynamic>? _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations) ??
        Translations(const Locale('en'));
  }

  String text(String key) {
    if (_localizedValues == null) {
      return '** $key not found';
    }
    return _localizedValues![key] != null
        ? _localizedValues![key] as String
        : '** $key not found';
  }

  String textWithArgs(String key, Map<String, dynamic> args) {
    var str = text(key);
    args.forEach((key, value) {
      str = str.replaceAll('\${$key}', value.toString());
    });
    return str;
  }

  static Future<Translations> load(Locale locale) async {
    final translations = Translations(locale);
    final jsonContent =
        await rootBundle.loadString('locale/i18n_${locale.languageCode}.json');
    _localizedValues = jsonDecode(jsonContent) as Map<String, dynamic>;
    return translations;
  }

  String get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

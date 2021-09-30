import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale locale;

  DemoLocalization(this.locale);

  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String>? _localizedValues;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String? getTranslatedValue(String key) {
    return _localizedValues![key];
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemolocalizationDelegate();
}

class _DemolocalizationDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemolocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemolocalizationDelegate old) => false;
}

import 'package:flutter/material.dart';
import 'package:regimental_app/generated/l10n.dart';

class SpecifiedLocalizationsDelegate extends LocalizationsDelegate<S> {
  final Locale specifiedLocale;

  const SpecifiedLocalizationsDelegate(this.specifiedLocale);

  @override
  bool isSupported(Locale locale) => specifiedLocale != null;

  @override
  Future<S> load(Locale locale) => S.load(specifiedLocale);

  @override
  bool shouldReload(SpecifiedLocalizationsDelegate old) => true;
}

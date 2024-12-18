import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

extension MiscX on BuildContext {
  AppLocalizations get l10n {
    return AppLocalizations.of(this) ?? AppLocalizationsEn();
  }
}

extension NullableStringX on String? {
  String get orEmpty => this ?? '';
}

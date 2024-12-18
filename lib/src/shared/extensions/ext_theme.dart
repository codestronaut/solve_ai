import 'package:flutter/material.dart';

extension BrightnessX on Brightness {
  bool get isLight => this == Brightness.light;
  bool get isDark => this == Brightness.dark;
}

extension ThemeX on BuildContext {
  /// Get access to TextTheme across the BuildContext.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get access to the current Brightness (app).
  Brightness get brightness => Theme.of(this).brightness;

  /// Get access to the current Brightness (platform).
  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  /// Check if the current brightness is light.
  bool get isLightMode => brightness.isLight && platformBrightness.isLight;

  /// Check if the current brightness is dark.
  bool get isDarkMode => brightness.isDark && platformBrightness.isDark;
}

extension TextStyleX on TextStyle? {
  /// Get TextStyle object with 'NewYork' as the default font family.
  TextStyle? get ny => this?.copyWith(fontFamily: 'NewYork');

  /// Get TextStyle object with 'SanFransisco' as the default font family.
  TextStyle? get sf => this?.copyWith(fontFamily: 'SanFransisco');
}

import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import 'ext_theme.dart';

extension OverlaysX on BuildContext {
  Future<T?> showSheet<T>({
    required Widget Function(BuildContext) builder,
    Color? lightBackgroundColor,
    Color? darkBackgroundColor,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) {
    final lightBackground = lightBackgroundColor ?? ColorName.backgroundLight;
    final darkBackground = darkBackgroundColor ?? ColorName.backgroundDark;

    return showModalBottomSheet<T>(
      context: this,
      useSafeArea: true,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: isLightMode ? lightBackground : darkBackground,
      builder: builder,
    );
  }
}

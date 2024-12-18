import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import 'ext_theme.dart';

extension OverlaysX on BuildContext {
  Future<T?> showSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) {
    const lightBackground = ColorName.backgroundLight;
    const darkBackground = ColorName.backgroundDark;

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

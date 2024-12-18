import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalCard extends StatelessWidget {
  const GlobalCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(context.spacingMd),
      decoration: BoxDecoration(
        color: context.isLightMode
            ? ColorName.backgroundSecondaryLight
            : ColorName.backgroundSecondaryDark,
        borderRadius: context.spacingLg.borderRadius,
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

enum GlobalButtonType { primary, secondary }

extension GlobalButtonTypeX on GlobalButtonType {
  bool get isPrimary => this == GlobalButtonType.primary;
  bool get isSecondary => this == GlobalButtonType.secondary;
}

class GlobalButton extends StatelessWidget {
  const GlobalButton.primary({
    super.key,
    this.fullWidth = false,
    this.foregroundColor,
    this.backgroundColor,
    required this.onTap,
    required this.child,
  })  : type = GlobalButtonType.primary,
        borderColor = null;

  const GlobalButton.secondary({
    super.key,
    this.fullWidth = false,
    this.foregroundColor,
    this.borderColor,
    required this.onTap,
    required this.child,
  })  : type = GlobalButtonType.secondary,
        backgroundColor = null;

  final GlobalButtonType type;
  final bool fullWidth;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case GlobalButtonType.primary:
        return SizedBox(
          width: fullWidth ? context.deviceWidth : null,
          child: FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              foregroundColor: foregroundColor ?? Colors.white,
              backgroundColor: backgroundColor ?? ColorName.primary,
              padding: EdgeInsets.all(context.spacingMd),
              textStyle: context.textTheme.bodyLarge.sf
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            child: child,
          ),
        );
      case GlobalButtonType.secondary:
        return SizedBox(
          width: fullWidth ? context.deviceWidth : null,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: foregroundColor ?? ColorName.primary,
              side: BorderSide(color: borderColor ?? ColorName.primary),
              padding: EdgeInsets.all(context.spacingMd),
              textStyle: context.textTheme.bodyLarge.sf
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            child: child,
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalListTile extends StatelessWidget {
  const GlobalListTile({
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    required this.title,
  });

  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        titleTextStyle: context.textTheme.titleMedium.ny
            ?.copyWith(fontWeight: FontWeight.w700),
        leading: leading,
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: context.spacingMd,
            ),
        tileColor: context.isLightMode
            ? ColorName.quaternary
            : ColorName.quaternaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: context.spacingMd.borderRadius,
        ),
      ),
    );
  }
}

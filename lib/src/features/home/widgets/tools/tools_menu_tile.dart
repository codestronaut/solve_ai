import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/assets/colors.gen.dart';
import '../../../../shared/extensions/ext_dimens.dart';
import '../../../../shared/extensions/ext_theme.dart';

class ToolsMenuTile extends StatelessWidget {
  const ToolsMenuTile({
    super.key,
    this.onTap,
    required this.iconPath,
    required this.title,
  });

  final VoidCallback? onTap;
  final String iconPath;
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
        leading: SvgPicture.asset(iconPath),
        trailing: Icon(
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

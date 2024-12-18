import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_card.dart';

class PermissionCard extends StatelessWidget {
  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isGranted = false,
  });

  final Widget icon;
  final String title;
  final String description;
  final bool isGranted;

  @override
  Widget build(BuildContext context) {
    final checkedIndicator = Assets.icons.icCheckCircle.svg(
      colorFilter: const ColorFilter.mode(ColorName.primary, BlendMode.srcIn),
    );

    return GlobalCard(
      child: Row(
        spacing: context.spacingMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isGranted ? checkedIndicator.animate().fade() : icon,
          Expanded(
            child: ListTile(
              title: Text(title),
              subtitle: Text(description),
              titleTextStyle: context.textTheme.titleMedium.ny?.copyWith(
                color: CupertinoColors.label.resolveFrom(context),
              ),
              subtitleTextStyle: context.textTheme.bodyMedium.sf?.copyWith(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
            ),
          ),
        ],
      ),
    );
  }
}

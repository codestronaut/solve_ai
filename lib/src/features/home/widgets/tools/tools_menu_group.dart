import 'package:flutter/cupertino.dart';

import '../../../../shared/assets/colors.gen.dart';
import '../../../../shared/extensions/ext_dimens.dart';
import '../../../../shared/extensions/ext_theme.dart';
import 'tools_menu_tile.dart';

class ToolsMenuGroup extends StatelessWidget {
  const ToolsMenuGroup({
    super.key,
    required this.title,
    required this.subtitle,
    this.menuTiles = const <ToolsMenuTile>[],
  });

  final String title;
  final String subtitle;
  final List<ToolsMenuTile> menuTiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacingMd),
      decoration: BoxDecoration(
        color: context.isLightMode
            ? ColorName.backgroundSecondaryLight
            : ColorName.backgroundSecondaryDark,
        borderRadius: context.spacingLg.borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium.sf?.copyWith(
              color: CupertinoColors.label.resolveFrom(context),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: context.textTheme.titleSmall.sf?.copyWith(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
          context.spacingMd.vSpace,
          ListView.separated(
            shrinkWrap: true,
            itemCount: menuTiles.length,
            itemBuilder: (context, index) => menuTiles[index],
            separatorBuilder: (context, index) => context.spacingMd.vSpace,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

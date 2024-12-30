import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../solve_ai_app_router.dart';
import '../widgets/tools/tools_menu.dart';
import '../widgets/tools/tools_menu_group.dart';
import '../widgets/tools/tools_menu_tile.dart';

@RoutePage()
class HomeToolsPage extends StatelessWidget {
  const HomeToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toolsMenuGroupsList = List.generate(
      toolsMenuGroups.length,
      (index) => ToolsMenuGroup(
        title: switch (index) {
          0 => context.l10n.askAiTitle,
          1 => context.l10n.writeTitle,
          _ => context.l10n.languageTitle,
        },
        subtitle: switch (index) {
          0 => context.l10n.askAiSubtitle,
          1 => context.l10n.writeSubtitle,
          _ => context.l10n.languageSubtitle,
        },
        menuTiles: toolsMenuGroups[index].map(
          (toolsMenu) {
            return ToolsMenuTile(
              onTap: () => context.pushRoute(ChatRoute(toolsMenu: toolsMenu)),
              iconPath: toolsMenu.getIconPath(),
              title: toolsMenu.getLabel(context),
            );
          },
        ).toList(),
      ),
    );

    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: toolsMenuGroupsList.length,
        itemBuilder: (context, index) => toolsMenuGroupsList[index],
        separatorBuilder: (context, index) => context.spacingMd.vSpace,
        padding: EdgeInsets.all(context.spacingMd).copyWith(
          top: context.statusBarHeight + context.spacingMd,
        ),
      ),
    );
  }
}

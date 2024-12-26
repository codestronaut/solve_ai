import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../widgets/tools/tools_menu_group.dart';
import '../widgets/tools/tools_menu_tile.dart';

@RoutePage()
class HomeToolsPage extends StatelessWidget {
  const HomeToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuGroups = [
      ToolsMenuGroup(
        title: context.l10n.askAiTitle,
        subtitle: context.l10n.askAiSubtitle,
        menuTiles: [
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatAskAnything.path,
            title: context.l10n.askAiAnything,
          ),
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatSummarize.path,
            title: context.l10n.askAiSummarize,
          ),
        ],
      ),
      ToolsMenuGroup(
        title: context.l10n.writeTitle,
        subtitle: context.l10n.writeSubtitle,
        menuTiles: [
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatDraftEssay.path,
            title: context.l10n.writeDraftEssay,
          ),
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatImprove.path,
            title: context.l10n.writeImprove,
          ),
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatChangeTone.path,
            title: context.l10n.writeChangeTone,
          ),
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatParaphrase.path,
            title: context.l10n.writeParaphrase,
          ),
        ],
      ),
      ToolsMenuGroup(
        title: context.l10n.languageTitle,
        subtitle: context.l10n.languageSubtitle,
        menuTiles: [
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatTranslate.path,
            title: context.l10n.languageTranslate,
          ),
          ToolsMenuTile(
            onTap: () {},
            iconPath: Assets.icons.icFeatFixGrammar.path,
            title: context.l10n.languageFixGrammar,
          ),
        ],
      ),
    ];

    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: menuGroups.length,
        itemBuilder: (context, index) => menuGroups[index],
        separatorBuilder: (context, index) => context.spacingMd.vSpace,
        padding: EdgeInsets.all(context.spacingMd).copyWith(
          top: context.statusBarHeight + context.spacingMd,
        ),
      ),
    );
  }
}

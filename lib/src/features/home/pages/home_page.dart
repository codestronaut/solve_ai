import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../solve_ai_app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBodyBehindAppBar: true,
      appBarBuilder: (context, tabsRouter) {
        return PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.isLightMode
                      ? ColorName.backgroundLight.withValues(alpha: 0.4)
                      : ColorName.backgroundDark.withValues(alpha: 0.4),
                ),
                child: AppBar(
                  title: Text(
                    switch (tabsRouter.activeIndex) {
                      0 => context.l10n.navScan,
                      1 => context.l10n.navTools,
                      2 => context.l10n.navChat,
                      3 => context.l10n.navHistory,
                      _ => context.l10n.appName,
                    },
                  ),
                  titleTextStyle: context.textTheme.headlineMedium.ny
                      ?.copyWith(fontWeight: FontWeight.w700),
                  actions: [
                    IconButton(
                      onPressed: () => context.pushRoute(const ProfileRoute()),
                      icon: Assets.icons.icSettings.svg(
                        colorFilter: ColorFilter.mode(
                          CupertinoColors.label.resolveFrom(context),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      routes: const [
        HomeScanRoute(),
        HomeToolsRoute(),
        HomeChatRoute(),
        HomeHistoryRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          onTap: (index) => tabsRouter.setActiveIndex(index),
          currentIndex: tabsRouter.activeIndex,
          items: [
            buildNavItem(
              activeIconPath: Assets.icons.icScanFilled.path,
              iconPath: Assets.icons.icScan.path,
              label: context.l10n.navScan,
            ),
            buildNavItem(
              iconPath: Assets.icons.icTools.path,
              label: context.l10n.navTools,
            ),
            buildNavItem(
              iconPath: Assets.icons.icChat.path,
              label: context.l10n.navChat,
            ),
            buildNavItem(
              iconPath: Assets.icons.icHistory.path,
              label: context.l10n.navHistory,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem buildNavItem({
    String? activeIconPath,
    required String iconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          CupertinoColors.tertiaryLabel.resolveFrom(context),
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        activeIconPath ?? iconPath,
        colorFilter: const ColorFilter.mode(
          ColorName.primary,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}

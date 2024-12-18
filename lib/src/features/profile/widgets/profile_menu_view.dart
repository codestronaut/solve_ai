import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_card.dart';
import '../../../shared/widgets/global_list_tile.dart';
import '../../../solve_ai_di.dart';
import '../managers/profile_bloc.dart';
import 'profile_appearance_sheet.dart';

class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final profileMenu = [
          GlobalListTile(
            onTap: () => context.showSheet(
              builder: (_) => Container(
                decoration: BoxDecoration(
                  color: context.isLightMode
                      ? ColorName.backgroundSecondaryLight
                      : ColorName.backgroundSecondaryDark,
                  borderRadius: BorderRadius.vertical(
                    top: (context.spacingMd * 2).radius,
                  ),
                ),
                child: const ProfileAppearanceSheet(),
              ),
              lightBackgroundColor: Colors.transparent,
              darkBackgroundColor: Colors.transparent,
            ),
            leading: Assets.icons.icAppearanceColored.svg(),
            title: context.l10n.appearance,
          ),
          GlobalListTile(
            onTap: () => locator<FirebaseAuth>().signOut(),
            leading: Assets.icons.icLogoutColored.svg(),
            title: context.l10n.logout,
          ),
        ];

        return GlobalCard(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: profileMenu.length,
            itemBuilder: (context, index) => profileMenu[index],
            separatorBuilder: (context, index) => context.spacingMd.vSpace,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}

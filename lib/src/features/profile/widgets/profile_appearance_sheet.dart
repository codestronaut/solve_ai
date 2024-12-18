import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_bottom_sheet.dart';
import '../../../shared/widgets/global_list_tile.dart';
import '../managers/profile_bloc.dart';

class ProfileAppearanceSheet extends StatelessWidget {
  const ProfileAppearanceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final activeThemeMode = profileState.themeMode;

        return GlobalBottomSheet(
          title: context.l10n.appearance,
          child: Column(
            spacing: context.spacingMd,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(ThemeMode.values.length, (index) {
              final themeMode = ThemeMode.values[index];
              return GlobalListTile(
                onTap: () {
                  context.read<ProfileBloc>().add(
                        ProfileEvent.updateThemeMode(themeMode),
                      );
                },
                leading: switch (themeMode) {
                  ThemeMode.system => const Icon(Icons.auto_awesome),
                  ThemeMode.light => const Icon(Icons.light_mode),
                  ThemeMode.dark => const Icon(Icons.dark_mode),
                },
                title: switch (themeMode) {
                  ThemeMode.system => context.l10n.system,
                  ThemeMode.light => context.l10n.lightMode,
                  ThemeMode.dark => context.l10n.darkMode,
                },
                trailing: themeMode == activeThemeMode
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: ColorName.primary,
                      )
                    : const SizedBox(),
              );
            }),
          ),
        );
      },
    );
  }
}

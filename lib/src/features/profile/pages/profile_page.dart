import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../managers/profile_bloc.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_view.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(const ProfileEvent.get());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.isLightMode
                    ? ColorName.backgroundLight.withOpacity(0.4)
                    : ColorName.backgroundDark.withOpacity(0.4),
              ),
              child: AppBar(
                title: Text(context.l10n.profile),
                titleTextStyle: context.textTheme.headlineMedium.ny
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.spacingMd).copyWith(
            top: context.appBarHeight + context.spacingMd,
          ),
          child: Column(
            spacing: context.spacingMd,
            children: const [ProfileHeaderCard(), ProfileMenuView()],
          ),
        ),
      ),
    );
  }
}

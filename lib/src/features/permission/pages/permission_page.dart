import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/models/permission/permission_item.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_button.dart';
import '../managers/permission_bloc.dart';
import '../widgets/permission_card.dart';

@RoutePage()
class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    final permissionItems = [
      PermissionItem(
        iconPath: Assets.icons.icCamera.path,
        title: context.l10n.camera,
        description: context.l10n.cameraDescription,
      ),
      PermissionItem(
        iconPath: Assets.icons.icGallery.path,
        title: context.l10n.gallery,
        description: context.l10n.galleryDescription,
      ),
      PermissionItem(
        iconPath: Assets.icons.icMicrophone.path,
        title: context.l10n.microphone,
        description: context.l10n.microphoneDescription,
      ),
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.spacingXlg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.enablePermission,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge.ny?.copyWith(
                  color: CupertinoColors.label.resolveFrom(context),
                ),
              ),
              context.spacingXs.vSpace,
              Text(
                context.l10n.enablePermissionDescription,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge.sf?.copyWith(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              BlocBuilder<PermissionBloc, PermissionState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: context.spacingXlg * 2,
                    ),
                    itemCount: permissionItems.length,
                    itemBuilder: (context, index) {
                      final permissionItem = permissionItems[index];
                      return PermissionCard(
                        icon: SvgPicture.asset(
                          permissionItem.iconPath,
                          colorFilter: ColorFilter.mode(
                            CupertinoColors.label.resolveFrom(context),
                            BlendMode.srcIn,
                          ),
                        ),
                        title: permissionItem.title,
                        description: permissionItem.description,
                        isGranted: switch (index) {
                          0 => state.isCameraAccessGranted,
                          1 => state.isGalleryAccessGranted,
                          2 => state.isMicrophoneAccessGranted,
                          _ => false,
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return context.spacingMd.vSpace;
                    },
                  );
                },
              ),
              BlocBuilder<PermissionBloc, PermissionState>(
                builder: (context, state) {
                  return GlobalButton.primary(
                    onTap: () {
                      if (state.isAllGranted) {
                        context.read<PermissionBloc>().add(
                              const PermissionEvent.complete(),
                            );
                      } else {
                        context.read<PermissionBloc>().add(
                              const PermissionEvent.ask(),
                            );
                      }
                    },
                    fullWidth: true,
                    child: state.isAllGranted
                        ? Text(context.l10n.proceed)
                        : Text(context.l10n.allow),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

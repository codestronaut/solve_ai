import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_card.dart';
import '../managers/profile_bloc.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final currentUser = profileState.currentUser;
        return GlobalCard(
          child: Row(
            spacing: context.spacingMd,
            children: [
              CachedNetworkImage(
                imageUrl: (currentUser?.photoURL).orEmpty,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: context.spacingXlg * 2,
                    height: context.spacingXlg * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.isLightMode
                            ? ColorName.secondary
                            : ColorName.secondaryDark,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        width: context.spacingXxs,
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                errorListener: (e) => Logger('CachedNetworkImage').warning(e),
                errorWidget: (context, url, error) {
                  return Container(
                    width: context.spacingXlg * 2,
                    height: context.spacingXlg * 2,
                    decoration: BoxDecoration(
                      color: context.isLightMode
                          ? ColorName.quaternary
                          : ColorName.quaternaryDark,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.isLightMode
                            ? ColorName.secondary
                            : ColorName.secondaryDark,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        width: context.spacingXxs,
                      ),
                    ),
                    child: Center(
                      child: Assets.icons.icUser.svg(
                        colorFilter: ColorFilter.mode(
                          CupertinoColors.label.resolveFrom(context),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (currentUser?.displayName).orEmpty,
                    style: context.textTheme.titleMedium.sf?.copyWith(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    (currentUser?.email).orEmpty,
                    style: context.textTheme.bodyMedium.ny?.copyWith(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

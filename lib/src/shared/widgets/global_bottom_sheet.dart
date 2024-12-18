import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_theme.dart';

class GlobalBottomSheet extends StatelessWidget {
  const GlobalBottomSheet({
    super.key,
    this.title,
    this.child,
    this.bottom,
    this.fullHeight = false,
  });

  final String? title;
  final Widget? child;
  final Widget? bottom;
  final bool fullHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: fullHeight ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(context.spacingXs),
                  child: Container(
                    width: context.spacingXlg * 3,
                    height: context.spacingXxs,
                    decoration: BoxDecoration(
                      color: context.isLightMode
                          ? ColorName.backgroundLight
                          : ColorName.backgroundDark,
                    ),
                  ),
                ),
                Container(
                  width: context.deviceWidth,
                  padding: EdgeInsets.only(
                    left: context.spacingMd,
                    top: context.spacingXs,
                    right: context.spacingMd,
                    bottom: context.spacingXs,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      Text(
                        title.orEmpty,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineSmall.ny?.copyWith(
                          color: CupertinoColors.label.resolveFrom(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        child: ClipOval(
                          child: Material(
                            color: context.isLightMode
                                ? ColorName.secondary
                                : ColorName.secondaryDark,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: SizedBox(
                                width: context.spacingMd * 2.4,
                                height: context.spacingMd * 2.4,
                                child: Icon(
                                  Icons.close,
                                  size: context.spacingLg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(context.spacingMd),
                  child: child ?? const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

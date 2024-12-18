import 'package:flutter/cupertino.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_theme.dart';

class OnboardingContentView extends StatelessWidget {
  const OnboardingContentView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.spacingXs,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.headlineLarge.ny?.copyWith(
            color: CupertinoColors.label.resolveFrom(context),
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge.sf?.copyWith(
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';

class OnboardingAgreementView extends StatelessWidget {
  const OnboardingAgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = CupertinoColors.tertiaryLabel.resolveFrom(context);
    final textStyle = context.textTheme.bodyMedium.sf?.copyWith(
      decorationColor: textColor,
      color: textColor,
    );

    return Animate(
      effects: const [FadeEffect()],
      delay: const Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacingLg),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: context.l10n.agreements,
            style: textStyle,
            children: [
              WidgetSpan(child: context.spacingXxs.hSpace),
              TextSpan(
                text: context.l10n.agreementsTerms,
                style: textStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              WidgetSpan(child: context.spacingXxs.hSpace),
              TextSpan(text: context.l10n.and),
              WidgetSpan(child: context.spacingXxs.hSpace),
              TextSpan(
                text: context.l10n.agreementsPrivacyPolicy,
                style: textStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

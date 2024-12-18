import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_indexed_stack.dart';
import '../managers/onboarding_cubit.dart';
import 'onboarding_agreement_view.dart';

class OnboardingFooterView extends StatelessWidget {
  const OnboardingFooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return AnimatedSize(
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: context.spacingSm,
            children: [
              GlobalIndexedStack(
                index: state.page,
                children: List.generate(3, (index) {
                  if (index < 2) {
                    return GlobalButton.primary(
                      fullWidth: true,
                      onTap: () => context.read<OnboardingCubit>().next(),
                      child: Text(context.l10n.proceed),
                    );
                  }

                  /// [MARK]
                  /// Currently, the login is limited to Google sign in only
                  /// because Apple sign in requires Apple Developer Program
                  /// enrollment.

                  // return const AuthButton.google();
                  return const SizedBox();

                  // return Platform.isIOS
                  //     ? const AuthButton.apple()
                  //     : const AuthButton.google();
                }),
              ),
              if (state.page == 2) const OnboardingAgreementView(),
            ],
          ),
        );
      },
    );
  }
}

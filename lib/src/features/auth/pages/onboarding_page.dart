import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_indexed_stack.dart';
import '../../../solve_ai_di.dart';
import '../managers/onboarding_cubit.dart';
import '../widgets/onboarding_content_view.dart';
import '../widgets/onboarding_footer_view.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingCubit onboardingCubit;

  @override
  void initState() {
    onboardingCubit = locator<OnboardingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onboardingCubit,
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: GlobalIndexedStack(
                    index: state.page,
                    children: [
                      context.isLightMode
                          ? Assets.images.onboarding1a.svg()
                          : Assets.images.onboarding1aDark.svg(),
                      context.isLightMode
                          ? Assets.images.onboarding2.svg()
                          : Assets.images.onboarding2Dark.svg(),
                      context.isLightMode
                          ? Assets.images.onboarding3.image()
                          : Assets.images.onboarding3Dark.image(),
                    ],
                  ),
                ),
                Container(
                  height: context.deviceHeight / 2.5,
                  padding: EdgeInsets.all(context.spacingXlg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GlobalIndexedStack(
                        index: state.page,
                        children: [
                          OnboardingContentView(
                            title: context.l10n.onboarding1Title,
                            subtitle: context.l10n.onboarding1Subtitle,
                          ),
                          OnboardingContentView(
                            title: context.l10n.onboarding2Title,
                            subtitle: context.l10n.onboarding2Subtitle,
                          ),
                          OnboardingContentView(
                            title: context.l10n.onboarding3Title,
                            subtitle: context.l10n.onboarding3Subtitle,
                          ),
                        ],
                      ),
                      const OnboardingFooterView(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

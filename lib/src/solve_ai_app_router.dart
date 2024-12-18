import 'package:auto_route/auto_route.dart';

import 'features/auth/pages/onboarding_page.dart';

part 'solve_ai_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class SolveAIAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: OnboardingRoute.page),
      ];
}

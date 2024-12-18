import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/auth/pages/onboarding_page.dart';
import 'features/home/pages/home_chat_page.dart';
import 'features/home/pages/home_history_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/home_scan_page.dart';
import 'features/home/pages/home_tools_page.dart';
import 'features/permission/managers/permission_bloc.dart';
import 'features/permission/pages/permission_page.dart';
import 'solve_ai_di.dart';

part 'solve_ai_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class SolveAIAppRouter extends RootStackRouter {
  SolveAIAppRouter({required PermissionBloc permissionBloc})
      : _permissionBloc = permissionBloc;

  final PermissionBloc _permissionBloc;

  @override
  List<AutoRoute> get routes {
    final guards = [AuthGuard(permissionBloc: _permissionBloc)];

    return [
      AutoRoute(path: '/', page: OnboardingRoute.page, guards: guards),
      AutoRoute(path: '/permission', page: PermissionRoute.page),
      AutoRoute(
        path: '/home',
        page: HomeRoute.page,
        children: [
          AutoRoute(path: 'scan', page: HomeScanRoute.page),
          AutoRoute(path: 'tools', page: HomeToolsRoute.page),
          AutoRoute(path: 'chat', page: HomeChatRoute.page),
          AutoRoute(path: 'history', page: HomeHistoryRoute.page),
          RedirectRoute(path: '*', redirectTo: 'scan'),
        ],
      ),
    ];
  }
}

class AuthGuard extends AutoRouteGuard {
  const AuthGuard({required this.permissionBloc});
  final PermissionBloc permissionBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    permissionBloc.stream.listen((permissionState) {
      locator<FirebaseAuth>().authStateChanges().listen((currentUser) {
        if (currentUser != null) {
          if (permissionState.isAllGranted && permissionState.isComplete) {
            resolver.redirect(const HomeRoute(), replace: true);
          } else {
            resolver.redirect(const PermissionRoute(), replace: true);
          }
        } else {
          resolver.next();
        }
      });
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/auth/managers/auth_bloc.dart';
import 'features/permission/managers/permission_bloc.dart';
import 'shared/assets/colors.gen.dart';
import 'shared/extensions/ext_theme.dart';
import 'solve_ai_app_router.dart';
import 'solve_ai_di.dart';

class SolveAIApp extends StatefulWidget {
  const SolveAIApp({super.key});

  @override
  State<SolveAIApp> createState() => _SolveAIAppState();
}

class _SolveAIAppState extends State<SolveAIApp> {
  late final AuthBloc authBloc;
  late final PermissionBloc permissionBloc;
  late final SolveAIAppRouter appRouter;

  @override
  void initState() {
    authBloc = locator<AuthBloc>();
    permissionBloc = locator<PermissionBloc>();
    permissionBloc.add(const PermissionEvent.get());
    appRouter = SolveAIAppRouter(permissionBloc: permissionBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authBloc),
        BlocProvider(create: (context) => permissionBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: ColorName.primary,
          scaffoldBackgroundColor: ColorName.backgroundLight,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: context.textTheme.bodySmall.sf,
            selectedLabelStyle: context.textTheme.bodySmall.sf,
            backgroundColor: CupertinoColors.systemBackground.color,
            unselectedItemColor: CupertinoColors.tertiaryLabel.color,
            selectedItemColor: ColorName.primary,
          ),
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          primaryColor: ColorName.primary,
          scaffoldBackgroundColor: ColorName.backgroundDark,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: context.textTheme.bodySmall.sf,
            selectedLabelStyle: context.textTheme.bodySmall.sf,
            backgroundColor: CupertinoColors.systemBackground.darkColor,
            unselectedItemColor: CupertinoColors.tertiaryLabel.darkColor,
            selectedItemColor: ColorName.primary,
          ),
        ),
        themeMode: ThemeMode.dark,
        routerConfig: appRouter.config(),
      ),
    );
  }
}

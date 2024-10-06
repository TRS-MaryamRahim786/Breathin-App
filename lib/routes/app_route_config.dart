import 'package:breathin_app/routes/routes.dart';
import 'package:breathin_app/screens/auth/login/view/login_screen.dart';
import 'package:breathin_app/screens/home/view/dashboard_screen.dart';
import 'package:breathin_app/screens/landing_page/view/landing_screen.dart';
import 'package:breathin_app/screens/language/view/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login/bloc/login_bloc.dart';
import '../screens/auth/login/cubits/terms_cubit.dart';
import '../screens/home/bloc/home_bloc.dart';
import '../screens/language/bloc/language_bloc.dart';
import '../services/firebase/firebase_auth.dart';
import '../services/shared-pref/shared-pref-service.dart';

class MyAppRouter {
  MyAppRouter._();

  static final _instance = MyAppRouter._();

  static MyAppRouter get instance => _instance;

  GoRouter get router => _router;
  late final GoRouter _router =
      GoRouter(initialLocation: Routes.landing, routes: <RouteBase>[
    GoRoute(
      path: Routes.landing,
      name: Routes.landing,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const MaterialPage(child: LandindScreen());
      },
    ),
    GoRoute(
      path: Routes.language,
      name: Routes.language,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage(
            child: BlocProvider(
          create: (context) => LanguageBloc(),
          child: LanguageScreen(),
        ));
      },
    ),
    GoRoute(
      path: Routes.login,
      name: Routes.login,
      pageBuilder: (BuildContext context, GoRouterState state) {
        String selectedLanguage = state.extra.toString();
        return MaterialPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => AuthBloc(authService: FirebaseAuthService())),
              BlocProvider(create: (_) => TermsCubit()),
              BlocProvider(create: (_) => LanguageBloc()),
            ],
            child: AuthScreen(language: selectedLanguage),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomeBloc(FirebaseAuthService())),
            ],
            child: DashboardScreen(),
          ),
        );
      },
    ),
  ]);
}

import 'package:breathin_app/routes/app_route_config.dart';
import 'package:breathin_app/screens/auth/auth/bloc/auth_bloc.dart';
import 'package:breathin_app/services/firebase/firebase_auth.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return BlocProvider(
      create: (context) => AuthBloc(authService: FirebaseAuthService()),
      child: MaterialApp.router(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Breathin App',
        theme: ThemeData(
            primaryColor: Colors.grey,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
            dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
        routerConfig: MyAppRouter.instance.router,
      ),
    );
  }
}

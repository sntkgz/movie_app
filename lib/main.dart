import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/auth_cubit.dart';
import 'package:my_app/screens/onboarding_screen.dart';
import 'package:my_app/screens/wrapper_screen.dart';

import 'core/services/locator.dart';
import 'screens/landing_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await setupLocators();
    runApp(MyApp());
  } catch (e) {
    print('setupLocatorsError: $e');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authCubit = AuthCubit();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 0), () async {
      await authCubit.checkUserLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthUninitialized) {
              return SplashScreen();
            } else if (state is AuthOnboarding) {
              return OnboardingScreen();
            } else if (state is AuthUnauthenticated) {
              return WrapperScreen();
            } else if (state is AuthAuthenticated) {
              return LandingScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/movie_cubit.dart';

import 'core/services/locator.dart';
import 'cubit/auth_cubit.dart';
import 'router/app_router.dart';
import 'screens/landing_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/wrapper_screen.dart';

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
  final appRouter = AppRouter();

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
        BlocProvider(create: (context) => MovieCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
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

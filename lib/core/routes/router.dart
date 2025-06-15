import 'package:flutter/material.dart';
import '../../home/presentation/pages/home_screen.dart';
import '../../home/presentation/pages/main_screen.dart';
import '../../login/presentation/pages/intro_screen.dart';
import '../../login/presentation/pages/login_screen.dart';
import '../../login/presentation/pages/registration_screen.dart';
import '../../login/presentation/pages/registration_success_screen.dart';
import '../../login/presentation/pages/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case AppRoutes.registerSuccess:
        return MaterialPageRoute(builder: (_) => const RegistrationSuccessScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
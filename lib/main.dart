import 'package:cinematika/favorites/presentation/pages/FavoritesScreen.dart';
import 'package:cinematika/profile/presentation/pages/profile_screen.dart';
import 'package:cinematika/tv/presentation/pages/tv_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/locator.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'core/themes/colors.dart';
import 'home/presentation/pages/home_screen.dart';
import 'login/presentation/manager/auth_bloc.dart';
import 'home/presentation/manager/home/home_bloc.dart';
import 'home/presentation/manager/search/search_bloc.dart';
import 'movie_detail/presentation/pages/movie_detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    setupLocator();
    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Error initializing app: $e'))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        // BlocProvider<HomeBloc>(create: (context) => getIt<HomeBloc>()),
        // BlocProvider<SearchBloc>(create: (context) => getIt<SearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: appRouter.onGenerateRoute,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          // Additional theme customizations (optional)
          textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

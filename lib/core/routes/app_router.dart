import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:investement_app/features/Auth/select_category_screen.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/features/Auth/sign_in/presentation/login_screen.dart';
import 'package:investement_app/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:investement_app/features/Auth/sign_up/presentation/secound_sign_up_.dart';
import 'package:investement_app/features/Auth/sign_up/presentation/sign_up.dart';
import 'package:investement_app/features/Auth/landing_page.dart';
import 'package:investement_app/features/settings/screen/setting_screen.dart';
import 'package:investement_app/features/splash_screen.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: SplashScreen.id,
    routes: [
      GoRoute(
        path: SplashScreen.id,
        name: SplashScreen.id,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.id,
        name: LoginScreen.id,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: OnboardingScreen.id,
        name: OnboardingScreen.id,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: SignUpPage.id,
        name: SignUpPage.id,
        builder: (context, state) {
          final String type = state.extra as String;
          return SignUpPage(type: type);
        },
      ),
      GoRoute(
        path: Homepage.id,
        name: Homepage.id,
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: LandingPage.id,
        name: LandingPage.id,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: SelectCategoryScreen.id,
        name: SelectCategoryScreen.id,
        builder: (context, state) => const SelectCategoryScreen(),
      ),
      GoRoute(
        path: SecoundSignUpPage.id,
        name: SecoundSignUpPage.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          return SecoundSignUpPage(
            name: extra['name'] as String,
            email: extra['email'] as String,
            password: extra['password'] as String,
            type: extra['type'] as String,
            image: extra['image'] as File,
          );
        },
      ),
      GoRoute(
          path: BottomNavBar.id,
          name: BottomNavBar.id,
          builder: (context, state) {
            final int? index = state.extra as int?;
            return BottomNavBar(navigatedIndex: index);
          }),
      GoRoute(
          path: SettingsScreen.id,
          name: SettingsScreen.id,
          builder: (context, state) {
            return const SettingsScreen();
          }),
    ],
  );
}

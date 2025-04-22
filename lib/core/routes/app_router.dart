import 'package:go_router/go_router.dart';
import 'package:investement_app/features/Auth/select_auth_type_screen.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/homeScreen.dart';
import 'package:investement_app/features/login/screens/login_screen.dart';
import 'package:investement_app/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:investement_app/features/sign_up/screen/signUp.dart';
import 'package:investement_app/features/sign_up/screen/startPage.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: OnboardingScreen.id,
    routes: [
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
        builder: (context, state) => const SignUpPage(),
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
        path: SelectAuthTypeScreen.id,
        name: SelectAuthTypeScreen.id,
        builder: (context, state) => const SelectAuthTypeScreen(),
      ),
      GoRoute(
          path: BottomNavBar.id,
          name: BottomNavBar.id,
          builder: (context, state) {
            final int? index = state.extra as int?;
            return BottomNavBar(navigatedIndex: index);
          }),
    ],
  );
}

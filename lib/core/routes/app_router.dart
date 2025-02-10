import 'package:go_router/go_router.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/features/login/screens/login_screen.dart';
import 'package:investement_app/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:investement_app/features/sign_up/signUp.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: SignUpPage.id,
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
        path: HomeScreen.id,
        name: HomeScreen.id,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

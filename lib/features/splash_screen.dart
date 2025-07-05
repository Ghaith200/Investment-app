import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/features/Auth/landing_page.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const id = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (prefs.getString('first') == null) {
      prefs.setString('first', 'true');
    }
    final first = prefs.getString('first');
    if (first == 'true') {
      context.go(OnboardingScreen.id);
    } else {
      if (token != null && token.isNotEmpty) {
        context.go(BottomNavBar.id); // ✅ Go to HomePagef
      } else {
        context.go(LandingPage.id); // ⬅️ Go to LandingPage
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

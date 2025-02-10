import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String id = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.onboarding1.image(
            width: 250,
            height: 250,
          ),
        ],
      )),
    );
  }
}

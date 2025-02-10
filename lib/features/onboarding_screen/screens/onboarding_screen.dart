import 'package:flutter/material.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/gen/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String id = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> onborading = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: AppColors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Image.asset(Assets.images.arrowRight.path),
        ),
      ),
      body:const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
      ),
    );
  }
}

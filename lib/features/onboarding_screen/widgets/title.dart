import 'package:flutter/material.dart';

class OnboardingTitle extends StatelessWidget {
  final String title;
  const OnboardingTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OnboardingSubtitle extends StatelessWidget {
  final String title;
  const OnboardingSubtitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
    );
  }
}

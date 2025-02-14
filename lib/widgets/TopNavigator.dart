import 'package:flutter/material.dart';

class TopNavigator extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const TopNavigator({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

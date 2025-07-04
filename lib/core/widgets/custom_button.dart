import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: width ?? MediaQuery.sizeOf(context).width * 0.9,
            height: height ?? 60,
            decoration: BoxDecoration(
              color: const Color(0xFF304FFE),
              borderRadius: BorderRadius.circular(28),
            ),
            child: TextButton(
              onPressed: onPressed,
              child: Center(
                child: child ??
                    Text(
                      text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              Assets.images.btnShape1.path,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

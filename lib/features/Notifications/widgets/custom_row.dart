import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String leftText;
  final String rightText;
  final VoidCallback? onTap;
  const CustomRow({
    super.key,
    required this.leftText,
    this.rightText = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              rightText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

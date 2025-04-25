import 'package:flutter/material.dart';

class SquaredButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const SquaredButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}

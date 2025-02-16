import 'package:flutter/material.dart';

class Squaredbutton extends StatelessWidget {
  final String text;
  final IconData icon;

  const Squaredbutton({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.blueAccent.withOpacity(0.3),
        elevation: 5,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.bold,
              // color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: Colors.blue, size: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool isPassword;
  final ValueChanged<String>? onChanged; // ✅ تم الإضافة

  const TextFieldWidget({
    this.label,
    this.icon,
    this.isPassword = false,
    this.onChanged, // ✅ تم الإضافة
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      onChanged: onChanged, 
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

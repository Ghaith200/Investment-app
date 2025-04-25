import 'package:flutter/material.dart';

class Customlisttile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final bool showDivider;
  final VoidCallback onTap;
  final String time;
  const Customlisttile({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.showDivider = false,
    required this.onTap,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(size.width * 0.02),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 15),
        ),
        onTap: onTap,
      ),
    );
  }
}

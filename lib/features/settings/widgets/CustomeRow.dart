import 'package:flutter/material.dart';

class Customelisttile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final Color color;
  const Customelisttile({
    super.key,
    required this.title,
    required this.onTap,
    this.showDivider = false,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.05,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    color: color,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
            if (showDivider)
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
          ],
        ),
      ),
    );
  }
}

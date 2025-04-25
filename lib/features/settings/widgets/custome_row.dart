import 'package:flutter/material.dart';

class Customelisttile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final Color color;
  final IconData? leadingIcon;
  final Color? iconColor;
  final double fontSize;
  final FontWeight fontWeight;

  const Customelisttile({
    super.key,
    required this.title,
    required this.onTap,
    this.showDivider = false,
    this.color = Colors.black,
    this.leadingIcon,
    this.iconColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      splashColor: theme.primaryColor.withOpacity(0.1),
      highlightColor: theme.primaryColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      leadingIcon,
                      color: iconColor ?? theme.primaryColor,
                      size: 24,
                    ),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: color,
                      fontWeight: fontWeight,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ],
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Divider(
                  color: Colors.grey[300],
                  height: 1,
                  thickness: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

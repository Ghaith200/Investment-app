import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CustomAuthBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: Colors.grey),
          )),
      leading: IconButton(
        icon:
            const HeroIcon(HeroIcons.chevronLeft, style: HeroIconStyle.outline),
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

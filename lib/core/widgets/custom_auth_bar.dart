import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CustomAuthBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAuthBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (context.mounted) {
                context.pop();
              } else {
                log('ERROR : context isnt mounted ');
              }
            },
            child: const HeroIcon(
              HeroIcons.chevronLeft,
              style: HeroIconStyle.outline,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

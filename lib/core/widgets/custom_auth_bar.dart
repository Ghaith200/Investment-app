// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CustomAuthBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButton;
  const CustomAuthBar({
    super.key,
    this.isBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (context.mounted) {
                context.pop();
              } else {
                log('ERROR : context isnt mounted');
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

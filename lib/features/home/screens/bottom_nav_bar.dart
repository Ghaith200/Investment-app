import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, this.navigatedIndex});
  static const String id = '/bottomNavBarItem';
  final int? navigatedIndex;

  static void switchToTab(BuildContext context, int index) {
    final _BottomNavBarState? state =
        context.findAncestorStateOfType<_BottomNavBarState>();
    state?.updateSelectedIndex(index);
  }

  @override
  State createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _homeIndex = 0;
  late int _selectedIndex;

  final List<Widget> pages = [
    const Homepage(),
    const Center(
        child: Text("Profile Screen")), //Todo: Replace with your actual screen
    const Center(child: Text("Cart Screen")), //Todo: Replace with your actual screen
    const Center(child: Text("saved Screen")), //Todo: Replace with your actual screen
    const Center(child: Text("Plans Screen")), //Todo: Replace with your actual screen
  ];

  void updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigatedIndex ?? _homeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        top: 0,
        backgroundColor: AppColors.blackWhite,
        color: AppColors.blue,
        activeColor: AppColors.blue,
        height: 70,
        style: TabStyle.fixedCircle,
        cornerRadius: 20,
        curveSize: 115,
        items: const [
          TabItem(
              icon: HeroIcon(
                HeroIcons.home,
                style: HeroIconStyle.solid,
                color: AppColors.blue,
              ),
              title: "Home"),
          TabItem(icon: Icons.shopping_cart, title: "Chat"),
          TabItem(icon: Icons.add, title: "Add"),
          TabItem(icon: Icons.list, title: "Saved"),
          TabItem(icon: Icons.card_travel, title: "Card"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

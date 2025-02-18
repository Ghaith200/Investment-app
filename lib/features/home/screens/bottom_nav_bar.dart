import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/features/home/screens/homeScreen.dart';

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
  final int _homeIndex = 2;
  late int _selectedIndex;

  final List<Widget> pages = [
    Center(child: Text("Profile Screen")), // Replace with your actual screen
    Center(child: Text("Cart Screen")), // Replace with your actual screen
    const Homepage(),
    Center(child: Text("Reservations Screen")), // Replace with your actual screen
    Center(child: Text("Plans Screen")), // Replace with your actual screen
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
        backgroundColor: Colors.grey,
        height: 70,
        activeColor: Colors.white,
        style: TabStyle.fixedCircle,
        cornerRadius: 20,
        curveSize: 115,
        color: Colors.white,
        items: const [
          TabItem(icon: Icons.person, title: "Profile"),
          TabItem(icon: Icons.shopping_cart, title: "Cart"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.list, title: "Reservations"),
          TabItem(icon: Icons.card_travel, title: "Plans"),
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

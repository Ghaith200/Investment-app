import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/core/models/user_model.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/features/myBuisness/screens/my_buissness.dart';
import 'package:investement_app/features/my_investments/data/get_offers_cubit.dart';
import 'package:investement_app/features/my_investments/my_investments.dart';
import 'package:investement_app/features/profile/Screens/profile_screen.dart';
import 'package:investement_app/features/profile/data/profile_cubit.dart';
import 'package:investement_app/features/profile/models/profile_model.dart';
import 'package:investement_app/features/profile/service/profile_service.dart';
import 'package:investement_app/features/projects/screens/create_project.dart';
import 'package:investement_app/features/wishlist/screens/wishlist_screen.dart';

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
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _homeIndex = 0;
  late int _selectedIndex;
  ProfileModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigatedIndex ?? _homeIndex;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = await ProfileService.getProfile();
      if (mounted) {
        setState(() => _currentUser = user);
      }
    } catch (e) {
      // Handle error
    }
  }

  void updateSelectedIndex(int index) {
    setState(() => _selectedIndex = index);
  }

  // Define navigation items based on user type
  List<TabItem> get _navigationItems {
    final items = [
      const TabItem(
        icon: Icons.add_circle_outline,
        title: 'Create',
      ),
      const TabItem(
        icon: Icons.favorite_border,
        title: 'Saved',
      ),
      const TabItem(
        icon: Icons.home_outlined,
        title: 'Home',
      ),
      _currentUser?.type == 'owner'
          ? const TabItem(
              icon: Icons.business_outlined,
              title: 'My Business',
            )
          : const TabItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Investments',
            ),
      const TabItem(
        icon: Icons.person,
        title: 'Profile',
      ),
    ];

    return items;
  }

  Widget _getPage(int index) {
    final items = _navigationItems;
    if (index >= items.length) return const SizedBox();

    switch (items[index].title) {
      case 'Home':
        return const Homepage();
      case 'Wishlist':
        return const WishlistPage();
      case 'Create':
        return BusinessFormPage();
      case 'My Business':
        return const MyBusinessesScreen();
      case 'Investments':
        return BlocProvider(
          create: (context) => OffersCubit(),
          child: const MyInvestments(),
        );
      case 'Profile':
        return BlocProvider(
          create: (context) => ProfileCubit(),
          child: const ProfileScreen(),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        color: Colors.grey,
        activeColor: AppColors.blue,
        height: 60,
        curveSize: 100,
        style: TabStyle.reactCircle,
        items: _navigationItems,
        initialActiveIndex: _selectedIndex,
        onTap: (int index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

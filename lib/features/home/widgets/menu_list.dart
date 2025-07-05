import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/features/Notifications/screens/notifications_screen.dart';
import 'package:investement_app/features/myBuisness/screens/my_buissness.dart';
import 'package:investement_app/features/my_investments/data/get_offers_cubit.dart';
import 'package:investement_app/features/my_investments/my_investments.dart';
import 'package:investement_app/features/profile/Screens/profile_screen.dart';
import 'package:investement_app/features/projects/screens/create_project.dart';
import 'package:investement_app/features/settings/screen/setting_screen.dart';
import 'package:investement_app/features/wishlist/screens/wishlist_screen.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
          icon: Icons.person,
          title: "Edit Profile",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }),
      MenuItem(icon: Icons.account_balance, title: "Bank & Card", onTap: () {}),
      MenuItem(
          icon: Icons.notifications,
          title: "Notification",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Notificationsscreen()));
          }),
      MenuItem(
          icon: Icons.settings,
          title: "Settings",
          onTap: () {
            context.pushNamed(SettingsScreen.id);
          }),
      MenuItem(icon: Icons.security, title: "Security", onTap: () {}),
      MenuItem(
          icon: Icons.assignment,
          title: "My Projects",
          onTap: () {
            context.pushNamed(MyBusinessesScreen.id);
          }),
      MenuItem(
          icon: Icons.edit,
          title: "Add New Project",
          onTap: () {
            context.pushNamed(BusinessFormPage.id);
          }),
      MenuItem(
          icon: Icons.bookmark,
          title: "Save For Later",
          onTap: () {
            context.pushNamed(WishlistPage.id);
          }),
      MenuItem(
          icon: Icons.login,
          title: "My Investments",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => OffersCubit(),
                          child: const MyInvestments(),
                        )));
          }),
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        thickness: 0.4,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            menuItems[index].icon,
            color: menuItems[index].iconColor,
          ),
          title: Text(
            menuItems[index].title,
            style: TextStyle(fontSize: 18, color: menuItems[index].color),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
          onTap: menuItems[index].onTap,
        );
      },
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black,
    this.iconColor = Colors.blue,
  });
}

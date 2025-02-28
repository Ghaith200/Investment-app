import 'package:flutter/material.dart';
import 'package:investement_app/features/Notifications/screens/NotificationsScreen.dart';
import 'package:investement_app/features/profile/Screens/profileScreen.dart';
import 'package:investement_app/features/settings/screen/settingScreen.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
          icon: Icons.person,
          title: "Edit Profile",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Profilescreen()));
          }),
      MenuItem(icon: Icons.account_balance, title: "Bank & Card", onTap: () {}),
      MenuItem(
          icon: Icons.notifications,
          title: "Notification",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notificationsscreen()));
          }),
      MenuItem(
          icon: Icons.settings,
          title: "Settings",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Settingscreen()));
          }),
      MenuItem(icon: Icons.security, title: "Security", onTap: () {}),
      MenuItem(icon: Icons.assignment, title: "My Project", onTap: () {}),
      MenuItem(icon: Icons.edit, title: "Add New Project", onTap: () {}),
      MenuItem(
          icon: Icons.account_balance_wallet,
          title: "My Investment",
          onTap: () {}),
      MenuItem(icon: Icons.bookmark, title: "Save For Later", onTap: () {}),
      MenuItem(
        icon: Icons.power_settings_new,
        title: "Log Out",
        onTap: () {},
        color: Colors.red,
        iconColor: Colors.red,
      ),
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => Divider(
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
          trailing: Icon(
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

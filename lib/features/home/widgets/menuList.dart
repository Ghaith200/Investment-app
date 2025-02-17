import 'package:flutter/material.dart';
import 'package:investement_app/features/settings/screen/settingScreen.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(Icons.person, "Edit Profile", () {}),
      MenuItem(Icons.account_balance, "Bank & Card", () {}),
      MenuItem(Icons.notifications, "Notification", () {}),
      MenuItem(Icons.settings, "Setting", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settingscreen()));
      }),
      MenuItem(Icons.security, "Security", () {}),
      MenuItem(Icons.assignment, "My Project", () {}),
      MenuItem(Icons.edit, "Add New Project", () {}),
      MenuItem(Icons.account_balance_wallet, "My Investment", () {}),
      MenuItem(Icons.bookmark, "Save For Later", () {}),
      MenuItem(Icons.power_settings_new, "Log Out", () {}),
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        thickness: 0.5,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(menuItems[index].icon, color: Colors.blue),
          title: Text(
            menuItems[index].title,
            style: TextStyle(fontSize: 18),
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

  MenuItem(
    this.icon,
    this.title,
    this.onTap,
  );
}

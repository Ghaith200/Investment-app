import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(Icons.person, "Edit Profile"),
    MenuItem(Icons.account_balance, "Bank & Card"),
    MenuItem(Icons.notifications, "Notification"),
    MenuItem(Icons.settings, "Setting"),
    MenuItem(Icons.security, "Security"),
    MenuItem(Icons.assignment, "My Project"),
    MenuItem(Icons.edit, "Add New Project"),
    MenuItem(Icons.account_balance_wallet, "My Investment"),
    MenuItem(Icons.bookmark, "Save For Later"),
    MenuItem(Icons.power_settings_new, "Log Out"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        thickness: 1,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(menuItems[index].icon, color: Colors.blue),
          title: Text(
            menuItems[index].title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          onTap: () {
            // Handle menu item click
          },
        );
      },
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;

  MenuItem(this.icon, this.title);
}

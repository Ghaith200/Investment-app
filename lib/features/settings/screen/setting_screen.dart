import 'package:flutter/material.dart';
import 'package:investement_app/features/settings/widgets/custome_row.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen.settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(0.0),
        //   child: Divider(
        //     color: Colors.grey,
        //     thickness: 1,
        //   ),
        // ),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Customelisttile(
              title: 'Account',
              onTap: () {},
            ),
            SizedBox(height: size.height * 0.03),
            Customelisttile(
              title: 'Notifications',
              onTap: () {},
              showDivider: true,
            ),
            Customelisttile(
              title: 'Newsletter',
              onTap: () {},
            ),
            SizedBox(height: size.height * 0.03),
            Customelisttile(
              title: 'Help',
              onTap: () {},
              showDivider: true,
            ),
            Customelisttile(
              title: 'About',
              onTap: () {},
            ),
            SizedBox(height: size.height * 0.03),
            Customelisttile(
              title: 'Logout',
              onTap: () {},
              color: Colors.redAccent.shade200,
            ),
            SizedBox(height: size.height * 0.03),
            Customelisttile(
              title: 'Rate Us on Google Play',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

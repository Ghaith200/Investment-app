import 'package:flutter/material.dart';
import 'package:investement_app/features/Notifications/widgets/CustomRow.dart';
import 'package:investement_app/features/Notifications/widgets/customListTile.dart';

class Notificationsscreen extends StatefulWidget {
  const Notificationsscreen({super.key});

  @override
  State<Notificationsscreen> createState() => _NotificationsscreenState();
}

class _NotificationsscreenState extends State<Notificationsscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            CustomRow(
              leftText: 'Today',
              rightText: 'Mark All As Read',
              onTap: () {},
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You have recieved a transAction',
              onTap: () {},
              time: '11:00 AM',
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You transferred money',
              onTap: () {},
              time: '12:00 AM',
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            CustomRow(leftText: 'Yesterday'),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You have recieved a transAction',
              onTap: () {},
              time: '11:00 AM',
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You transferred money',
              onTap: () {},
              time: '12:00 AM',
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            CustomRow(leftText: 'Last Week'),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You have recieved a transAction',
              onTap: () {},
              time: '11:00 AM',
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Customlisttile(
              title: 'TransAction Completed',
              icon: Icons.done,
              subtitle: 'You transferred money',
              onTap: () {},
              time: '12:00 AM',
            ),
          ],
        ),
      ),
    );
  }
}

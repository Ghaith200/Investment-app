import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/widgets/DrawerListTile.dart';
import 'package:investement_app/widgets/menuList.dart';
import 'package:investement_app/widgets/profileWidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FundX",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(Assets.images.logo.path, height: 50, width: 50),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 20),
            DrawerListtile(
              onTap: () {},
              title: Text(
                'My Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.close),
              TraillerIcon: Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ProfileWidget(),
            MenuList(),
          ],
        ),
      ),
      body: ListView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/widgets/CardsListview.dart';
import 'package:investement_app/widgets/DrawerListTile.dart';
import 'package:investement_app/widgets/TopNavigator.dart';
import 'package:investement_app/widgets/menuList.dart';
import 'package:investement_app/widgets/profileWidget.dart';
import 'package:investement_app/widgets/textfield.dart';

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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: TextFieldWidget(
                label: 'Search Any project', icon: Icons.search),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TopNavigator(onTap: () {}, title: 'Home'),
                TopNavigator(onTap: () {}, title: 'Chat'),
                TopNavigator(onTap: () {}, title: 'Saved'),
                TopNavigator(onTap: () {}, title: 'Card'),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'All Projects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          CardListView(
            cards: [
              {
                'image': Assets.images.logo.path,
                'title': 'Crypto',
                'subtitle': 'Bitcoin',
              },
              {
                'image': Assets.images.onboarding1.path,
                'title': 'onboarding1',
                'subtitle': 'shawn',
              },
              {
                'image': Assets.images.onboarding2.path,
                'title': 'onboarding2',
                'subtitle': 'cena',
              },
              {
                'image': Assets.images.logo.path,
                'title': 'Crypto',
                'subtitle': 'Bitcoin',
              },
              {
                'image': Assets.images.onboarding1.path,
                'title': 'onboarding1',
                'subtitle': 'shawn',
              },
              {
                'image': Assets.images.onboarding2.path,
                'title': 'onboarding2',
                'subtitle': 'cena',
              },
              {
                'image': Assets.images.logo.path,
                'title': 'Crypto',
                'subtitle': 'Bitcoin',
              },
              {
                'image': Assets.images.onboarding1.path,
                'title': 'onboarding1',
                'subtitle': 'shawn',
              },
              {
                'image': Assets.images.onboarding2.path,
                'title': 'onboarding2',
                'subtitle': 'cena',
              },
            ],
          ),
        ],
      ),
    );
  }
}

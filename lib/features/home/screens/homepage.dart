import 'package:flutter/material.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/widgets/CardsListview.dart';
import 'package:investement_app/widgets/DrawerListTile.dart';
import 'package:investement_app/widgets/TopNavigator.dart';
import 'package:investement_app/widgets/menuList.dart';
import 'package:investement_app/widgets/profileWidget.dart';
import 'package:investement_app/widgets/textfield.dart';

class Homepage extends StatefulWidget {
  static const String id = "/home";

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
              height: 20,
            ),
            ProfileWidget(),
            MenuList(),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: TextFieldWidget(
                label: 'Search Any project', icon: Icons.search),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
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
          SizedBox(height: 20),
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
          CustomTextFormField(
              hintText: 'hintText',
              prefixIcon: Icon(Icons.search),
              label: 'label')
        ],
      ),
    );
  }
}

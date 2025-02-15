import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/widgets/CardsListview.dart';
import 'package:investement_app/widgets/DrawerListTile.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Projects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showSortOptions(context);
                  },
                  child: Container(
                    height: size.height * 0.03,
                    width: size.width * 0.14,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Sort',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.sort),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: size.height * 0.02),
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

void _showSortOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text(
                'A-Z',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                print('A-Z selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.swap_vert),
              title: Text(
                'Z-A',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                print('Z-A selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: Text(
                'Newest First',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                print('Newest First selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.history_outlined),
              title: Text(
                'Oldest First',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                print('Oldest First selected');
              },
            ),
          ],
        ),
      );
    },
  );
}

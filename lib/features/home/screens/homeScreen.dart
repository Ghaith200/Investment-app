import 'package:flutter/material.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/widgets/cardListview.dart';
import 'package:investement_app/features/home/widgets/darwerListTile.dart';
import 'package:investement_app/features/home/widgets/menuList.dart';
import 'package:investement_app/features/home/widgets/profileWidget.dart';
import 'package:investement_app/features/home/widgets/textfield.dart';
import 'package:investement_app/features/profile/Screens/profileScreen.dart';
import 'package:investement_app/gen/assets.gen.dart';

class Homepage extends StatefulWidget {
  static const String id = "/home";

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
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profilescreen()));
            },
            child: Container(
                margin: EdgeInsets.only(right: size.width * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(150)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset(
                    Assets.images.profilePhoto.path,
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                )),
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
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/home/widgets/card_list_view.dart';
import 'package:investement_app/features/home/widgets/darwer_list_tile.dart';
import 'package:investement_app/features/home/widgets/menu_list.dart';
import 'package:investement_app/features/home/widgets/profile_widget.dart';
import 'package:investement_app/features/home/widgets/text_field.dart';
import 'package:investement_app/features/profile/Screens/profile_screen.dart';
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Profilescreen()));
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
            const SizedBox(height: 20),
            DrawerListtile(
              onTap: () {},
              title: const Text(
                'My Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.close),
              traillerIcon: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ProfileWidget(),
            const MenuList(),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            child: const TextFieldWidget(
                label: 'Search Any project', icon: Icons.search),
          ),

          SizedBox(height: size.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
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
                    child: const Row(
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
          const CustomTextFormField(
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text(
                'A-Z',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                if (kDebugMode) {
                  print('A-Z selected');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_vert),
              title: const Text(
                'Z-A',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text(
                'Newest First',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text(
                'Oldest First',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

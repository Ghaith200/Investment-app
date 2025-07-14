import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/features/Notifications/screens/notifications_screen.dart';
import 'package:investement_app/features/zoom_meetings/zoom_meeting.dart';
import 'package:investement_app/features/myBuisness/screens/my_buissness.dart';
import 'package:investement_app/features/my_investments/data/get_offers_cubit.dart';
import 'package:investement_app/features/my_investments/my_investments.dart';
import 'package:investement_app/features/profile/Screens/profile_screen.dart';
import 'package:investement_app/features/profile/models/profile_model.dart';
import 'package:investement_app/features/projects/screens/create_project.dart';
import 'package:investement_app/features/recent_deals/recent_deals_screen.dart';
import 'package:investement_app/features/settings/screen/setting_screen.dart';
import 'package:investement_app/features/wishlist/screens/wishlist_screen.dart';

class MenuList extends StatelessWidget {
  final ProfileModel? userProfile;
  const MenuList({super.key, this.userProfile});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        icon: Icons.person,
        title: "Edit Profile",
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      MenuItem(icon: Icons.account_balance, title: "Bank & Card", onTap: () {}),
      MenuItem(
        icon: Icons.notifications,
        title: "Notification",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Notificationsscreen()));
        },
      ),
      MenuItem(
        icon: Icons.settings,
        title: "Settings",
        onTap: () {
          context.pushNamed(SettingsScreen.id);
        },
      ),
      MenuItem(icon: Icons.security, title: "Security", onTap: () {}),
      MenuItem(
        icon: Icons.assignment,
        title: "My Projects",
        onTap: () {
          context.pushNamed(MyBusinessesScreen.id);
        },
      ),
      MenuItem(
        icon: Icons.edit,
        title: "Add New Project",
        onTap: () {
          context.pushNamed(BusinessFormPage.id);
        },
      ),
      MenuItem(
        icon: Icons.bookmark,
        title: "Save For Later",
        onTap: () {
          context.pushNamed(WishlistPage.id);
        },
      ),
      userProfile?.type == "investor"
          ? MenuItem(
              icon: Icons.account_balance_wallet,
              title: "My Investments",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => OffersCubit(),
                      child: const MyInvestments(),
                    ),
                  ),
                );
              },
            )
          : MenuItem(
              icon: Icons.account_balance_wallet,
              title: "My Deals",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecentDealsScreen()));
              },
            ),
      MenuItem(
        leadingWidget: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/images/zoom.png', fit: BoxFit.contain),
        ),
        title: "Zoom a mentor",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ZoomMeeting()),
          );
        },
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        thickness: 0.4,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          leading: item.leadingWidget ??
              (item.icon != null
                  ? Icon(
                      item.icon,
                      color: item.iconColor,
                    )
                  : null),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 18, color: item.color),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: item.onTap,
        );
      },
    );
  }
}

class MenuItem {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;
  final Widget? leadingWidget;

  MenuItem({
    this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black,
    this.iconColor = Colors.blue,
    this.leadingWidget,
  });
}

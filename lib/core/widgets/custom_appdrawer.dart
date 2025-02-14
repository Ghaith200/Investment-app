import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/constants/app_text_styles.dart';
import 'package:investement_app/core/models/user_model.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/utils/app_snack_bar.dart';
import 'package:investement_app/core/utils/storage.dart';
import 'package:investement_app/gen/assets.gen.dart';

class CustomAppdrawer extends StatefulWidget {
  const CustomAppdrawer({super.key});

  @override
  State<CustomAppdrawer> createState() => _CustomAppdrawerState();
}

class _CustomAppdrawerState extends State<CustomAppdrawer> {
  @override
  Widget build(BuildContext context) {
    // final UserModel user = Storage.instance.user;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.viewPaddingOf(context).top + 20),
            Text(
              "user.name",
              textAlign: TextAlign.center,
              style: AppTextStyles.hevoLight20BlackWhiteW900.copyWith(
                color: AppColors.lightBrown,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "user.phoneNumber",
              textAlign: TextAlign.center,
              style: AppTextStyles.hevoLight20BlackWhiteW900.copyWith(
                color: AppColors.lightBrown,
              ),
            ),
            const SizedBox(height: 30),
            AppDrawerItemWidget(
                top: true,
                title: 'الصفحة الرئيسية',
                icon: const Icon(Icons.home, color: AppColors.lightBrown),
                onTap: () {
                  // context.pushReplacementNamed(HomeScreen.id),
                }),
            AppDrawerItemWidget(
                title: "المستخدمين",
                icon: Icon(Icons.group),
                // icon: Assets.images.icons.users.image(
                //   width: 25,
                //   color: AppColors.lightBrown,
                // ),
                onTap: () {
                  // context.pushReplacementNamed(UsersScreen.id),
                }),
            AppDrawerItemWidget(
                title: "استقبال الطلبات",
                icon: Icon(Icons.group),
                // icon: Assets.images.icons.group.image(
                //   width: 25,
                //   color: AppColors.lightBrown,
                // ),
                onTap: () {
                  // context.pushReplacementNamed(UsersScreen.id),
                }),
            const Spacer(),
            AppDrawerItemWidget(
                top: true,
                icon: const Icon(Icons.phone, color: AppColors.lightBrown),
                title: 'تواصل معنا عبر الهاتف',
                onTap: () {
                  //_callPhoneNumber('00971505041741'),
                }),
            AppDrawerItemWidget(
                icon: const Icon(Icons.message, color: AppColors.lightBrown),
                title: 'تواصل معنا عبر الواتس',
                onTap: () {
                  // _launchWhatsApp('+971503136836'),
                }),
            AppDrawerItemWidget(
              bot: false,
              icon: const Icon(Icons.message, color: AppColors.lightBrown),
              title: 'تسجيل الخروج',
              onTap: () async {
                // await FirebaseAuth.instance.signOut();
                // await Storage.instance.logout();
                // if (context.mounted) {
                //   // context.pushReplacementNamed(LoginScreen.id);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _launchWhatsApp(String phoneNumber) async {
  //   final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

  // try {
  //   await launchUrl(whatsappUri,
  //       mode: LaunchMode.externalNonBrowserApplication);
  // } catch (e) {
  //   AppSnackBar.showSnackBar(context, 'Error launching WhatsApp');
  // }
}

// Future<void> _callPhoneNumber(String phoneNumber) async {
//   final String formattedPhoneNumber = phoneNumber.startsWith('00')
//       ? phoneNumber.replaceFirst('00', '+')
//       : phoneNumber;

//   final Uri uri = Uri(scheme: 'tel', path: formattedPhoneNumber);

//   try {
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       AppSnackBar.showSnackBar(context, 'Failed launching phone dialer');
//     }
//   } catch (e) {
//     AppSnackBar.showSnackBar(context, 'Failed launching phone dialer');
//   }
// }
// }

class AppDrawerItemWidget extends StatelessWidget {
  const AppDrawerItemWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.top = false,
      this.bot = true});

  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final bool top, bot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (top) const Divider(),
        ListTile(
          leading: icon,
          title: Text(title),
          onTap: onTap,
        ),
        if (bot) const Divider(),
      ],
    );
  }
}

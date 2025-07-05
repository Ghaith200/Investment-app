import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/home/data/logout_cubit.dart';
import 'package:investement_app/features/home/data/logout_state.dart';
import 'package:investement_app/features/settings/widgets/custome_row.dart';
import 'package:investement_app/features/Auth/landing_page.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  static const id = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => LogoutCubit(),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            // Navigate to Landing screen
            GoRouter.of(context).go(LandingPage.id);
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LogoutLoading;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.grey.shade200,
              child: ListView(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Customelisttile(title: 'Account', onTap: () {}),
                  SizedBox(height: size.height * 0.03),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return CustomSwitchTile(
                        title: 'Dark Mode',
                        value: themeMode == ThemeMode.dark,
                        onChanged: (_) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  Customelisttile(
                    title: 'Notifications',
                    onTap: () {},
                    showDivider: true,
                  ),
                  Customelisttile(title: 'Newsletter', onTap: () {}),
                  SizedBox(height: size.height * 0.03),
                  Customelisttile(
                    title: 'Help',
                    onTap: () {},
                    showDivider: true,
                  ),
                  Customelisttile(title: 'About', onTap: () {}),
                  SizedBox(height: size.height * 0.03),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Customelisttile(
                          title: 'Logout',
                          onTap: () {
                            context.read<LogoutCubit>().logout();
                          },
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
        },
      ),
    );
  }
}

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}

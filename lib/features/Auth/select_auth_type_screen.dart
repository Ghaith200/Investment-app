import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/features/login/screens/login_screen.dart';
import 'package:investement_app/features/sign_up/screen/signUp.dart';
import 'package:investement_app/gen/assets.gen.dart';

class SelectAuthTypeScreen extends StatelessWidget {
  static const String id = "/selectAuthType";

  const SelectAuthTypeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 30),
                    child:
                        Image.asset(Assets.images.startpage.path, height: 240),
                  ),
                  const SizedBox(height: 99),
                  CustomButton(
                      text: 'Log in',
                      onPressed: () {
                        context.pushNamed(LoginScreen.id);
                      }),
                  const SizedBox(height: 37),
                  CustomButton(
                      text: 'Sign up',
                      onPressed: () {
                        context.pushNamed(SignUpPage.id);
                      }),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: 'By Continuing You Accept Our '),
                    TextSpan(
                      text: '\nTerms Of Service',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    TextSpan(text: ' And '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

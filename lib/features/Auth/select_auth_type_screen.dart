import 'package:flutter/material.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
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
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Image.asset(Assets.images.startpage.path, height: 240),
                  SizedBox(height: 40),
                  CustomButton(text: 'Sign in', onPressed: () {}),
                  SizedBox(height: 20),
                  CustomButton(text: 'Log in', onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'By Continuing You Accept Our '),
                    TextSpan(
                      text: 'Terms Of Service',
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

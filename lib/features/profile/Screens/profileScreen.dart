import 'package:flutter/material.dart';
import 'package:investement_app/features/home/widgets/textfield.dart';
import 'package:investement_app/features/profile/widgets/PhotoWithIcon.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Photowithicon(),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  label: 'Full Name',
                  icon: Icons.person_outline,
                ),
                SizedBox(height: size.height * 0.02),
                TextFieldWidget(
                  label: 'User Name',
                  icon: Icons.alternate_email,
                ),
                SizedBox(height: size.height * 0.02),
                TextFieldWidget(
                  label: 'Phone Number',
                  icon: Icons.phone_android_outlined,
                ),
                SizedBox(height: size.height * 0.02),
                TextFieldWidget(
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),
                SizedBox(height: size.height * 0.02),
                TextFieldWidget(
                  label: 'Password',
                  icon: Icons.remove_red_eye,
                  isPassword: true,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.15),
          Opacity(
            opacity: 0.7,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              height: 75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                ),
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 29, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

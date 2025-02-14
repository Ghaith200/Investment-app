import 'package:flutter/material.dart';
import 'package:investement_app/features/home/screens/homepage.dart';
import 'package:investement_app/widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "/SignUp";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text('Add your personal Info',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text('This Info Needs To Be Accurate With Your ID Document',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(
            height: size.height * 0.1,
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
                SizedBox(height: size.height * 0.05),
                TextFieldWidget(
                  label: 'User Name',
                  icon: Icons.alternate_email,
                ),
                SizedBox(height: size.height * 0.05),
                TextFieldWidget(
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),
                SizedBox(height: size.height * 0.05),
                TextFieldWidget(
                  label: 'Password',
                  icon: Icons.remove_red_eye,
                  isPassword: true,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.12),
          Opacity(
            opacity: 0.5,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                },
                child: Text(
                  'Continue',
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

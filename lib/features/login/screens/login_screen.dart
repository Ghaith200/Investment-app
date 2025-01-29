import 'package:flutter/material.dart';
import 'package:investement_app/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          SizedBox(height: size.height * 0.04),
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                'Log In To Fundx',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: size.height * 0.05),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                TextFieldWidget(
                    label: 'Email', icon: Icons.email, isPassword: false),
                SizedBox(height: size.height * 0.05),
                TextFieldWidget(
                    label: 'Password',
                    icon: Icons.remove_red_eye_rounded,
                    isPassword: true),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.48),
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
                onPressed: () {},
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

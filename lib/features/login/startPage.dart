import 'package:flutter/material.dart';
import 'package:investement_app/features/login/login.dart';
import 'package:investement_app/features/login/signUp.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
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
          SizedBox(height: 10),
          Container(
            height: size.height * 0.4,
            // child: Image.asset('assets/images/startpage.png'),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpPage()));
              },
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 29, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 29, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              children: [
                Text(
                  'By Continuing, you agree to our',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              children: [
                Text(
                  'Terms and Conditions',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' And',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' Privacy Policy',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

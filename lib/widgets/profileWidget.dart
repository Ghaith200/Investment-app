import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Assets.images.logo.path,
                    height: size.height * .2,
                    width: size.width * 0.45,
                  )),
              Positioned(
                right: 0,
                bottom: 10,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue, size: 30),
                  onPressed: () {
                    // Edit profile action
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Fuck you Ghaith",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

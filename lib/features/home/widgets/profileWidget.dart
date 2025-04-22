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
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset(
                    Assets.images.newlogo.path,
                    height: size.height * .2,
                  )),
              Positioned(
                right: 0,
                bottom: 10,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue, size: 35),
                  onPressed: () {
                    // Todo: Edit profile action
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "FUND X",
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

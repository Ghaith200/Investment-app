import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';

class Photowithicon extends StatelessWidget {
  const Photowithicon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.amber,
      height: size.height * 0.2,
      width: size.width * 0.4,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage(Assets
                  .images.profilePhoto.path), // Replace with your image asset
              backgroundColor: Colors.grey[200],
            ),
            Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.05,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 27,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

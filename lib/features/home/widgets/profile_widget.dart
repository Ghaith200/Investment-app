import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';

class ProfileWidget extends StatelessWidget {
  final String? profileImage;

  const ProfileWidget({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // ✅ Use Image.network if profileImage exists, otherwise fallback
              ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: profileImage != null
                    ? Image.network(
                        'http://10.0.2.2:8000/storage/$profileImage',
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.images.profilePhoto.path,
                            height: size.height * 0.2,
                            width: size.height * 0.2,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        Assets.images.profilePhoto.path,
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
              ),
              // Edit Icon Positioned
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.shade300,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 28,
                    ),
                    onPressed: () {
                      // TODO: Edit profile action
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/Auth/sign_up/presentation/secound_sign_up_.dart';
import 'package:investement_app/gen/assets.gen.dart';

class SignUpPage extends StatefulWidget {
  static const id = '/signup';
  final String type;
  const SignUpPage({super.key, required this.type});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? profileImage;

  Future<void> pickProfileImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              Assets.images.topScreenShapes.path,
              width: screenWidth * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAuthBar(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  'Add your personal Info :',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: GestureDetector(
                                    onTap: pickProfileImage,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColors.blue,
                                      backgroundImage: profileImage != null
                                          ? FileImage(profileImage!)
                                          : null,
                                      child: profileImage == null
                                          ? const Icon(Icons.camera_alt,
                                              color: Colors.white)
                                          : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                CustomTextFormField(
                                  label: 'Full Name',
                                  hintText: 'full name',
                                  controller: nameController,
                                  prefixIcon: const HeroIcon(
                                    HeroIcons.user,
                                    color: AppColors.blue,
                                    style: HeroIconStyle.solid,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  label: 'Email',
                                  hintText: 'email',
                                  controller: emailController,
                                  prefixIcon: const HeroIcon(
                                    HeroIcons.envelope,
                                    color: AppColors.blue,
                                    style: HeroIconStyle.solid,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  label: 'Password',
                                  hintText: 'password',
                                  controller: passwordController,
                                  prefixIcon: const HeroIcon(
                                    HeroIcons.lockClosed,
                                    color: AppColors.blue,
                                    style: HeroIconStyle.solid,
                                  ),
                                ),
                                const Spacer(),
                                CustomButton(
                                  text: 'Next',
                                  onPressed: () {
                                    if (profileImage != null) {
                                      context.pushNamed(
                                        SecoundSignUpPage.id,
                                        extra: {
                                          'name': nameController.text,
                                          'email': emailController.text,
                                          'password': passwordController.text,
                                          'image': profileImage,
                                          'type': widget.type,
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please pick a profile image')),
                                      );
                                    }
                                  },
                                  height: 60,
                                ),
                                const SizedBox(height: 35),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

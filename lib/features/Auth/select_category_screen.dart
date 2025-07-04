import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/features/Auth/sign_in/presentation/login_screen.dart';
import 'package:investement_app/features/Auth/sign_up/presentation/sign_up.dart';
import 'package:investement_app/gen/assets.gen.dart';

class SelectCategoryScreen extends StatelessWidget {
  static const String id = '/selectCategory';
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose By Type:',
                            style: TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Explore our knowledge base and see everything we have to offer.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.07),

                        // Owner Box
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(SignUpPage.id, extra: 'owner'),
                          child: Container(
                            width: screenWidth * 0.6,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: BorderSide.strokeAlignOutside)
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.images.owner.path,
                                  width: 70,
                                  height: 70,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Owner',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Investor Box
                        GestureDetector(
                          onTap: () => context.pushNamed(SignUpPage.id,
                              extra: 'investor'),
                          child: Container(
                            width: screenWidth * 0.6,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: BorderSide.strokeAlignOutside)
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.images.investor.path,
                                  width: 70,
                                  height: 70,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Investor',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
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

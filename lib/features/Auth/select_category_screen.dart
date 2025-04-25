import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/features/login/screens/login_screen.dart';
import 'package:investement_app/gen/assets.gen.dart';

class SelectCategoryScreen extends StatelessWidget {
  static const String id = '/selectCategory';
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              Assets.images.topScreenShapes.path,
              width: MediaQuery.sizeOf(context).width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAuthBar(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose By Type:',
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'Explore our knowledge base and see everything we have to offer.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(LoginScreen.id);
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
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
                            const Text(
                              'Owner',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(LoginScreen.id);
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
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
                            const Text(
                              'Investor',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

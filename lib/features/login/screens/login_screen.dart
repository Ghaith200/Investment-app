import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAuthBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add your Personal info:',
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'This info needs to be accurate with your iD document.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          label: 'Full Name',
                          hintText: 'Full Name',
                          prefixIcon: HeroIcon(
                            HeroIcons.users,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: 'User Name',
                          hintText: 'User Name',
                          prefixIcon: HeroIcon(
                            HeroIcons.atSymbol,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: 'Email',
                          hintText: 'Email',
                          prefixIcon: HeroIcon(
                            HeroIcons.envelope,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: 'Password',
                          hintText: 'Password',
                          prefixIcon: HeroIcon(
                            HeroIcons.eye,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back_ios_new),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     bottom: PreferredSize(
    //       preferredSize: const Size.fromHeight(1.0),
    //       child: Container(
    //         color: Colors.grey,
    //         height: 1.0,
    //       ),
    //     ),
    //   ),
    //   body: ListView(
    //     children: [
    //       SizedBox(height: size.height * 0.04),
    //       Container(
    //           margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
    //           child: Text(
    //             'Log In To Fundx',
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 26,
    //                 fontWeight: FontWeight.bold),
    //           )),
    //       SizedBox(height: size.height * 0.05),
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
    //         child: Column(
    //           children: [
    //             TextFieldWidget(
    //                 label: 'Email', icon: Icons.email, isPassword: false),
    //             SizedBox(height: size.height * 0.05),
    //             TextFieldWidget(
    //                 label: 'Password',
    //                 icon: Icons.remove_red_eye_rounded,
    //                 isPassword: true),
    //             SizedBox(height: size.height * 0.01),
    //             Row(
    //               children: [
    //                 Text(
    //                   'Forget Password?',
    //                   style: TextStyle(
    //                     color: Colors.blueAccent,
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: size.height * 0.48),
    //       Opacity(
    //         opacity: 0.5,
    //         child: Container(
    //           margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
    //           height: 75,
    //           child: ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Colors.blueAccent.shade400,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //               shadowColor: Colors.blueAccent,
    //               elevation: 10,
    //             ),
    //             onPressed: () {},
    //             child: Text(
    //               'Continue',
    //               style: TextStyle(fontSize: 29, color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

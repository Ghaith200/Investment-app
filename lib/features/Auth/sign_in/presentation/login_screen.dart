import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/Auth/sign_in/data/login_cubit.dart';
import 'package:investement_app/features/Auth/sign_in/data/login_state.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/core/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.pushNamed(BottomNavBar.id);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
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
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.02,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight),
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      const Spacer(flex: 2),
                                      Column(
                                        children: [
                                          const Text(
                                            'Welcome Back!',
                                            style: TextStyle(
                                              color: AppColors.darkGreen,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Please log in with your credentials.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 35),
                                          CustomTextFormField(
                                            label: 'Email',
                                            hintText: 'Enter your email',
                                            controller: emailController,
                                            prefixIcon: const HeroIcon(
                                              HeroIcons.envelope,
                                              style: HeroIconStyle.solid,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextFormField(
                                            label: 'Password',
                                            hintText: 'Enter your password',
                                            controller: passwordController,
                                            prefixIcon: const HeroIcon(
                                              HeroIcons.lockClosed,
                                              style: HeroIconStyle.solid,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(flex: 3),
                                      state is LoginLoading
                                          ? const CircularProgressIndicator()
                                          : CustomButton(
                                              text: "Login",
                                              onPressed: () {
                                                context
                                                    .read<LoginCubit>()
                                                    .login(
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim(),
                                                    );
                                              },
                                              height: 62,
                                            ),
                                      const SizedBox(height: 50),
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
        },
      ),
    );
  }
}

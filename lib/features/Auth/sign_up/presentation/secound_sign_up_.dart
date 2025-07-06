import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/widgets/custom_auth_bar.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/Auth/sign_up/data/register_cubit.dart';
import 'package:investement_app/features/Auth/sign_up/data/register_state.dart';
import 'package:investement_app/features/Auth/sign_up/models/register_model.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/home_screen.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecoundSignUpPage extends StatefulWidget {
  static const id = '/secoundsignup';

  final String name;
  final String email;
  final String password;
  final File image;
  final String type;

  const SecoundSignUpPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.type,
  });

  @override
  State<SecoundSignUpPage> createState() => _SecoundSignUpPageState();
}

class _SecoundSignUpPageState extends State<SecoundSignUpPage> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  Future<void> pickBirthdate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.blue),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            final prefs = SharedPreferences.getInstance();
            prefs.then((sharedPrefs) {
              sharedPrefs.setString('token', state.token);
              sharedPrefs.setString('userId', state.token);
            });
            context.pushNamed(BottomNavBar.id, extra: 2);
          } else if (state is RegisterFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Registration Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.02,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                        label: 'Country',
                                        hintText: 'Select your country',
                                        controller: countryController,
                                        readOnly: true,
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            showPhoneCode: false,
                                            onSelect: (country) {
                                              countryController.text =
                                                  country.name;
                                            },
                                          );
                                        },
                                        prefixIcon: const HeroIcon(
                                          HeroIcons.map,
                                          color: AppColors.blue,
                                          style: HeroIconStyle.solid,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextFormField(
                                        label: 'Birthdate',
                                        hintText: 'yyyy-mm-dd',
                                        controller: birthdateController,
                                        readOnly: true,
                                        onTap: pickBirthdate,
                                        prefixIcon: const HeroIcon(
                                          HeroIcons.calendar,
                                          color: AppColors.blue,
                                          style: HeroIconStyle.solid,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextFormField(
                                        label: 'Title',
                                        hintText: 'title',
                                        controller: titleController,
                                        prefixIcon: const HeroIcon(
                                          HeroIcons.briefcase,
                                          color: AppColors.blue,
                                          style: HeroIconStyle.solid,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextFormField(
                                        label: 'Bio',
                                        hintText: 'Tell us about yourself',
                                        controller: bioController,
                                        maxLines: 4,
                                        prefixIcon: const HeroIcon(
                                          HeroIcons.documentText,
                                          color: AppColors.blue,
                                          style: HeroIconStyle.solid,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomButton(
                                height: 60,
                                text: state is RegisterLoading ? '' : 'Submit',
                                onPressed: () {
                                  final model = RegisterModel(
                                    name: widget.name,
                                    email: widget.email,
                                    password: widget.password,
                                    profileImage: widget.image,
                                    country: countryController.text,
                                    birthdate: birthdateController.text,
                                    title: titleController.text,
                                    bio: bioController.text,
                                    type: widget.type,
                                  );
                                  context.read<RegisterCubit>().register(model);
                                },
                                child: state is RegisterLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: 20),
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
        },
      ),
    );
  }
}

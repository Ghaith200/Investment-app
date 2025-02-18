import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/home/screens/homeScreen.dart';
import 'package:investement_app/features/onboarding_screen/widgets/Subtitle.dart';
import 'package:investement_app/features/onboarding_screen/widgets/title.dart';
import 'package:investement_app/gen/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0; // Track active slide index
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final List<Map<String, String>> onboardingSlides = [
    {
      "image": Assets.images.onboarding1.path,
      "title": "Set you financial goals",
      "subtitle":
          "Your goals will help us to formulate right recommendations for success"
    },
    {
      "image": Assets.images.onboarding2.path,
      "title": "Follow our tips and tricks",
      "subtitle": "We help our users to make the right financial decisions"
    },
    {
      "image": Assets.images.onboarding3.path,
      "title": "Save your money  conveniently",
      "subtitle": "Get 5% cash back for each transaction and spend it easily"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.blue,
        onPressed: () {
          if (currentIndex < onboardingSlides.length - 1) {
            carouselController.animateToPage(
              currentIndex + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            GoRouter.of(context).go(BottomNavBar.id, extra: 2);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Image.asset(Assets.images.arrowRight.path),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Carousel Slider
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: onboardingSlides.map((slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Expanded(
                            child: Image.asset(
                              slide["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingSlides.length,
                              (index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 4, // Fixed height for all lines
                                  width: index == currentIndex
                                      ? 40
                                      : 20, // Active line is wider
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? AppColors.blue
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Title (Bold)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: OnboardingTitle(title: slide["title"]!),
                          ),
                          const SizedBox(height: 20),
                          // Subtitle (Regular)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: OnboardingSubtitle(
                              title: slide["subtitle"]!,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Next Button
            ],
          ),
        ),
      ),
    );
  }
}

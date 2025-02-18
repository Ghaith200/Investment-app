import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_core/firebase_core.dart'; // Firebase
import 'package:investement_app/core/routes/app_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/utils/app_utils.dart';
import 'package:investement_app/core/utils/simple_observer.dart';
import 'package:investement_app/gen/assets.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(); // Ensure Firebase is initialized

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Bloc.observer = SimpleObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale("en"),
      path: 'i18n', // Ensure this folder exists
      fallbackLocale: const Locale("en"), // Fallback if locale is missing
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        AppScreenUtils.initUtils(context);
        return MaterialApp.router(
          title: "FundX",
          routeInformationParser: AppRouter.goRouter.routeInformationParser,
          routerDelegate: AppRouter.goRouter.routerDelegate,
          routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: AppColors.whiteBlack,
              ),
              color: AppColors.blackWhite,
            ),
            colorScheme: AppColors.scheme,
            primaryColor: AppColors.blue,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.blue.withOpacity(0.5),
              selectionHandleColor: AppColors.blue,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.blackWhite,
            fontFamily: Assets.fonts.questv1Bold,
          ),
        );
      },
    );
  }
}

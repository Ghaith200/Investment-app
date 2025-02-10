import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/core/routes/app_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/utils/app_utils.dart';
import 'package:investement_app/core/utils/simple_observer.dart';
import 'package:investement_app/gen/assets.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await dotenv.load();
  //FireBase Code

  //-Firebase Code
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // await BackDoorServices.main();
  // setupServiceLocator();

  // Storage.instance.isFirstTime = true;

  Bloc.observer = SimpleObserver();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        startLocale: const Locale("en"),
        path: 'i18n',
        child: const MyApp()),
  );
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            color: AppColors.whiteBlack, //change your color here
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

      // theme: AppColors.lightTheme,
      // darkTheme: AppColors.dartTheme,
      // themeMode:
      //     Storage.instance.isDarkMood ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

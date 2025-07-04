import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investement_app/app_theme.dart';
import 'package:investement_app/core/routes/app_router.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/utils/app_utils.dart';
import 'package:investement_app/core/utils/simple_observer.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/theme_cubit.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Bloc.observer = SimpleObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale("en"),
      path: 'i18n',
      fallbackLocale: const Locale("en"),
      child: BlocProvider(
        create: (_) => ThemeCubit(), // <- PROVIDER
        child: const MyApp(),
      ),
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
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: "FundX",
              routeInformationParser:
                  AppRouter.goRouter.routeInformationParser,
              routerDelegate: AppRouter.goRouter.routerDelegate,
              routeInformationProvider:
                  AppRouter.goRouter.routeInformationProvider,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
} 

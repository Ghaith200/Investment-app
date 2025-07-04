import 'package:flutter/material.dart';
import 'package:investement_app/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.blue,
          secondary: AppColors.blue.withOpacity(0.7),
        ),
        fontFamily: 'YourFont', // Optional
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.dark(
          primary: AppColors.blue,
          secondary: AppColors.blue.withOpacity(0.7),
        ),
        fontFamily: 'YourFont', // Optional
        useMaterial3: true,
      );
}

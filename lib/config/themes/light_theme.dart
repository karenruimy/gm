import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.whiteColor,

  /// -------------------------- Text Theme -------------------------- ///

  // Body:  small = 12, medium = 14, large = 16

  // Title: small = 14, medium = 16, large = 22

  // label: small = 11, medium = 12, large = 14

  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontFamily: 'MyFont',
      color: AppColors.greyColor,
      letterSpacing: 1,
    ),
  ).apply(
    bodyColor: AppColors.greyColor,
    displayColor: AppColors.greyColor,
  ),

  /// -------------------------- Color Scheme -------------------------- ///
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.primaryLight,
    primary: AppColors.primaryLight,
    primaryContainer: AppColors.lightGreyColor,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.whiteColor,
  ),

  cardTheme: const CardTheme(
    color: AppColors.whiteColor,
    surfaceTintColor: Colors.white,
    elevation: 5.0,
  ),

  splashFactory: InkSplash.splashFactory,
  dividerTheme: DividerThemeData(color: AppColors.greyColor.withOpacity(0.5)),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor,
    selectedItemColor: Color(0xFFE5252C),
    unselectedItemColor: Color(0xffB5B4B4),
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontSize: 12),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),

  /// -------------------------- Appbar Theme -------------------------- ///
  appBarTheme: const AppBarTheme(
    color: AppColors.transparent,
    // set status bar text color to dark...
    // systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: 'MyFont',
      fontSize: 25,
      letterSpacing: 0.7,
    ),
  ),

  /// -------------------------- Textfield Theme -------------------------- ///
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(fontSize: 14, color: AppColors.blackColor),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
    filled: true,
    fillColor: AppColors.whiteColor,
    errorStyle: const TextStyle(color: AppColors.red),

    /// Borders
    disabledBorder: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    border: _outlineInputBorder,
    errorBorder: _errorBorder,
    focusedErrorBorder: _errorBorder,
    focusedBorder: _outlineInputBorder.copyWith(
      borderSide: const BorderSide(
        color: AppColors.primaryLight,
      ),
    ),
  ),
);

final _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: const BorderSide(
    color: AppColors.greyColor,
  ),
);

final _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: const BorderSide(
    color: AppColors.red,
  ),
);

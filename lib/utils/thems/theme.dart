
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';


ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: MyColors.kMainColor,
    scaffoldBackgroundColor:MyColors.kMainBackroundColor,
    appBarTheme: AppBarTheme(centerTitle: false, elevation: 0, color: MyColors.kMainBackroundColor),
    iconTheme: const IconThemeData(color: MyColors.kSecondaryMainColor),
    textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.black),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => MyColors.kSecondaryMainColor),
      overlayColor:  MaterialStateColor.resolveWith((states) => MyColors.kSecondaryMainColor),
    ),

    colorScheme: const ColorScheme.light(
      primary: MyColors.kMainColor,
      onPrimary: MyColors.kOutlineTextFieldColor,
      onPrimaryContainer: MyColors.kSecondaryTextColor,
      secondary: MyColors.kSecondaryMainColor,
      secondaryContainer:MyColors.kTertiaryMainColor,
      onSecondary: MyColors.kQuaternaryMainColor,
      error: MyColors.red,
      onSurface: MyColors.black,
      background: MyColors.kText3Color,
      onBackground: MyColors.kBrandColor,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1.h,
      backgroundColor: MyColors.white,
      selectedItemColor: MyColors.kMainColor,
      unselectedItemColor: MyColors.kSecondaryMainColor,
      selectedIconTheme: const IconThemeData(color: MyColors.kMainColor),
      showUnselectedLabels: true,
    ),
  );
}



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'values_manager.dart';

ThemeData get themeDataLight {
  return ThemeData(
    // main color
    primaryColor: ColorManager.mainColor,
    primaryColorLight: ColorManager.lightColor,
    primaryColorDark: ColorManager.darkColor,
    disabledColor: ColorManager.disabledColor,
    // card Theme
    cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.disabledColor,
        elevation: AppSpacing.ap4),
    appBarTheme: AppBarTheme(
      toolbarHeight: 60,
      color: ColorManager.mainColor,
      elevation: AppSpacing.ap4,
      shadowColor: ColorManager.lightColor,
      iconTheme:
          IconThemeData(color: ColorManager.textColor, size: FontSize.s28),
      titleTextStyle: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s16),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.lightColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: ColorManager.lightColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: const Color.fromARGB(255, 255, 149, 42),
      unselectedItemColor: ColorManager.darkColor,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle:
          getBoldStyle(color: ColorManager.textColor, fontSize: FontSize.s18),
      selectedLabelStyle:
          getBoldStyle(color: ColorManager.textColor, fontSize: FontSize.s20),
    ),
// botton Theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.disabledColor,
      buttonColor: ColorManager.mainColor,
      splashColor: ColorManager.lightColor,
    ),

// botton Elevation Theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.mainColor,
        maximumSize: const Size(600, 200),
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.ap20, vertical: AppSpacing.ap8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.ap12)),
        textStyle: getRegularStyle(
            color: ColorManager.textColor, fontSize: FontSize.s24),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(ColorManager.textColor),
      ),
    ),
    textTheme: TextTheme(
      displayLarge:
          getLightStyle(color: ColorManager.textColor, fontSize: FontSize.s32),
      headlineLarge: getSimiBoldStyle(
          color: ColorManager.textColor, fontSize: FontSize.s32),
      labelLarge:
          getMediumStyle(color: ColorManager.textColor, fontSize: FontSize.s28),
      labelMedium:
          getMediumStyle(fontSize: FontSize.s20, color: ColorManager.textColor),
      labelSmall: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s24),
      titleLarge: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppSpacing.ap18),
      iconColor: ColorManager.darkColor,
      hintStyle:
          getRegularStyle(fontSize: FontSize.s24, color: ColorManager.gray),
      labelStyle:
          getMediumStyle(fontSize: FontSize.s20, color: ColorManager.gray),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.gray,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.mainColor,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.error,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap8))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorManager.mainColor, width: AppSpacing.ap1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14))),
    ),
  );
}

ThemeData get themeDataDark {
  return ThemeData(
    primaryColor: ColorManager.mainColor,
    primaryColorLight: ColorManager.lightColor,
    primaryColorDark: ColorManager.darkColor,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: ColorManager.textColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ColorManager.lightColor,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        textStyle: MaterialStateProperty.all(getRegularStyle(
            fontSize: FontSize.s16, color: ColorManager.textColor)),
      ),
    ),
  );
}

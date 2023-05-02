import 'package:curso_arquitetura/presentation/resources/color_manager.dart';
import 'package:curso_arquitetura/presentation/resources/font_manager.dart';
import 'package:curso_arquitetura/presentation/resources/styles_manager.dart';
import 'package:curso_arquitetura/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

OutlineInputBorder _outlineInputBorder(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: AppSize.s1_5),
    borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
  );
}

ThemeData getApplicationTheme() {
  return ThemeData(
    // Cores principais do aplicativo;
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.primary,
      onPrimary: ColorManager.primaryOpacity70,
      secondary: ColorManager.grey,
      onSecondary: ColorManager.white,
      background: ColorManager.white,
      onBackground: ColorManager.black,
      error: ColorManager.error,
      onError: ColorManager.white,
      surface: ColorManager.white,
      onSurface: ColorManager.black,
    ),

    // card view
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),
    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      bodySmall: getRegularStyle(color: ColorManager.grey1),
      bodyLarge: getRegularStyle(color: ColorManager.grey),
    ),

    // input deoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: _outlineInputBorder(ColorManager.grey),
      focusedBorder: _outlineInputBorder(ColorManager.primary),
      errorBorder: _outlineInputBorder(ColorManager.error),
      focusedErrorBorder: _outlineInputBorder(ColorManager.primary),
    ),
  );
}

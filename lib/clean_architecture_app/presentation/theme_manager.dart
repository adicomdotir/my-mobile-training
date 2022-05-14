import 'package:first_flutter/clean_architecture_app/presentation/color_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/font_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/styles_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primaryOpacity70,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ColorManager.grey,
      ),
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getReqularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
      buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getReqularStyle(color: ColorManager.white),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          subtitle1: getMediumStyle(
              color: ColorManager.lighGrey, fontSize: FontSize.s14),
          caption: getReqularStyle(color: ColorManager.grey1),
          bodyText1: getReqularStyle(color: ColorManager.grey)),
          
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(AppPadding.p8),
            hintStyle: getReqularStyle(color: ColorManager.grey1),
            labelStyle: getMediumStyle(color: ColorManager.darkGrey),
            errorStyle: getReqularStyle(color: ColorManager.error),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
            ),
          )
          );
}
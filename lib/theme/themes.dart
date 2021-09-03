import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimensions.dart';

final ThemeData appTheme = buildAppTheme();
final ThemeData systemTheme = setSystemTheme();

ThemeData buildAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.light(primary: kPrimaryColor),
    primaryColor: kPrimaryColor,
    accentColor: kPrimaryColor,
    scaffoldBackgroundColor: kWhite,
    canvasColor: kWhite,
    cardColor: kWhite,
    errorColor: kErrorRed,
    primaryTextTheme: buildAppTextTheme(GoogleFonts.poppinsTextTheme()),
    textTheme: buildAppTextTheme(GoogleFonts.montserratTextTheme()),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          elevation: 0,
          // titleTextStyle: GoogleFonts.comfortaa(),
          iconTheme: IconThemeData(color: kBlack),
          color: kTransparent,
          brightness: Brightness.light,
          textTheme: buildAppTextTheme(
            GoogleFonts.comfortaaTextTheme(),
          ),
        ),
    buttonTheme: ThemeData.light().buttonTheme.copyWith(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius / 5)),
          buttonColor: kPrimaryColor,
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
    ),
  );
}

TextTheme buildAppTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    headline1: textTheme.headline1.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.w400,
        color: kTextBlack,
        letterSpacing: 1),
    headline2: textTheme.headline2.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: kTextBlack,
        letterSpacing: 1),
    headline3: textTheme.headline3.copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: kTextBlack,
        letterSpacing: 1),
    headline4: textTheme.headline4.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: kTextBlack,
        letterSpacing: 1),
    subtitle1: textTheme.subtitle1.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: kTextBlack,
        letterSpacing: 1),
    subtitle2: textTheme.subtitle2.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: kTextBlack,
        letterSpacing: 1),
    bodyText1: textTheme.bodyText1.copyWith(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      color: kTextBlack,
      letterSpacing: 0.5,
    ),
    bodyText2: textTheme.bodyText2.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: kTextBlack,
        letterSpacing: 1),
    button: textTheme.button.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        color: kTextBlack,
        letterSpacing: 1),
    caption: textTheme.caption.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: kTextBlack,
        letterSpacing: 1),
  );
}

setSystemTheme() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

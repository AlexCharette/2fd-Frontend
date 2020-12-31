import 'package:flutter/material.dart';

class AppSizes {
  // TODO
  // ex: static const int titleFontSize = x;
}

class AppColors {
  // TODO
  static const blue = Color(0x002984);
  static const blueFaded = Color(0x3D608A);
  static const charcoal = Color(0x454545);
  static const red = Color(0xDE1018);
  static const white = Color(0xFFFFFF);
  static const buttonGreen = Color(0x45B94E);
  static const buttonRed = Color(0xBF4437);
  static const buttonBlue = Color(0x378DBF);
  static const buttonOrange = Color(0xBF8637);
  static const buttonCobalt = Color(0x3750BF);
}

// TODO alter defaults put in place currently
class Theme {
  static ThemeData of(context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.red,
        accentColor: AppColors.blue,
        appBarTheme: theme.appBarTheme.copyWith(
            color: AppColors.white,
            iconTheme: IconThemeData(color: AppColors.red),
            textTheme: theme.textTheme.copyWith(
                caption: TextStyle(color: AppColors.charcoal, fontSize: 18))),
        textTheme: theme.textTheme.copyWith(
          headline5: theme.textTheme.headline5
              .copyWith(fontSize: 48, color: AppColors.white),
        ));
  }
}

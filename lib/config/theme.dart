import 'package:flutter/material.dart';

class AppSizes {
  // TODO
  // ex: static const int titleFontSize = x;
}

class AppColors {
  // TODO
  static const red = Color(0xDE1018);
  static const blue = Color(0x002984);
  static const white = Color(0xFFFFFF);
  static const charcoal = Color(0x33373D);
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

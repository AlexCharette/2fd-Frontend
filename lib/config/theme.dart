import 'package:flutter/material.dart';
import 'package:local_storage_theme_manager_repository/local_storage_theme_manager_repository.dart';

class AppColors {
  // TODO: change the hex of the colors
  static const blue = Colors.blue; //Color(0x002984);
  static const blueFaded = Colors.lightBlueAccent; //Color(0x3D608A);
  static const charcoal = Colors.black12; //Color(0x454545);
  static const red = Colors.red; //Color(0xDE1018);
  static const white = Colors.white; //Color(0xFFFFFF);
  static const buttonGreen = Colors.green; //Color(0x45B94E);
  static const buttonRed = Colors.redAccent; //Color(0xBF4437);
  static const buttonBlue = Colors.blue; //Color(0x378DBF);
  static const buttonOrange = Colors.orange; //Color(0xBF8637);
  static const buttonCobalt = Colors.grey; //Color(0x3750BF);
}

class ThemeNotifier with ChangeNotifier {
  //###########################Light Theme########################
  final lightTheme = ThemeData(
    primaryColor: AppColors.white,
    accentColor: AppColors.blue,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.red),
        textTheme: TextTheme(
            caption: TextStyle(color: AppColors.charcoal, fontSize: 18))),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 75, letterSpacing: 2.0, color: AppColors.white, fontFamily: 'CastIron'),
      headline2: TextStyle(fontSize: 65, letterSpacing: 2.0, color: AppColors.white, fontFamily: 'CastIron'),
      headline3: TextStyle(fontSize: 55, letterSpacing: 2.0, color: AppColors.white, fontFamily: 'CastIron'),
      headline4: TextStyle(fontSize: 45, letterSpacing: 2.0, color: AppColors.white, fontFamily: 'CastIron'),
      headline5: TextStyle(fontSize: 35, letterSpacing: 2.0, color: AppColors.white, fontFamily: 'CastIron'),
      headline6: TextStyle(fontSize: 48, color: AppColors.white),
      button: TextStyle(letterSpacing: 2.0),
    ),
  );

  //TODO: Add other themes such as a dark theme

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ${value.toString()}');
      var themeMode = value ?? 'light';
      switch (themeMode) {
        case 'light':
          {
            _themeData = lightTheme;
            break;
          }
        default:
          {
            _themeData = lightTheme;
            break;
          }
      }
      notifyListeners();
    });
  }
  //Method to change to a light theme
  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  //TODO: implement method to change to wtv other themes that are added
}

// class AppSizes {
//   // TODO
//   // ex: static const int titleFontSize = x;
// }
//
//
// // TODO alter defaults put in place currently
// class Theme {
//   static ThemeData of(context) {
//     ThemeData theme = Theme.of(context);
//     return theme.copyWith(
//         primaryColor: AppColors.red,
//         accentColor: AppColors.blue,
//         appBarTheme: theme.appBarTheme.copyWith(
//             color: AppColors.white,
//             iconTheme: IconThemeData(color: AppColors.red),
//             textTheme: theme.textTheme.copyWith(
//                 caption: TextStyle(color: AppColors.charcoal, fontSize: 18))),
//         textTheme: theme.textTheme.copyWith(
//           headline5: theme.textTheme.headline5
//               .copyWith(fontSize: 48, color: AppColors.white),
//         ));
//   }
// }

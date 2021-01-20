import 'package:flutter/material.dart';
import 'package:local_storage_theme_manager_repository/local_storage_theme_manager_repository.dart';

class AppColors {
  static const blue = Color(0xFF002984);
  static const blueFaded = Color(0xFF3D608A);
  static const charcoal = Color(0xFF454545);
  static const red = Color(0xFFDE1018);
  static const white = Color(0xFFFFFFFF);
  static const buttonGreen = Color(0xFF45B94E);
  static const buttonRed = Color(0xFFBF4437);
  static const buttonBlue = Color(0xFF378DBF);
  static const buttonOrange = Color(0xFFBF8637);
  static const buttonCobalt = Color(0xFF3750BF);
}

class ThemeNotifier with ChangeNotifier {
  //###########################Light Theme########################
  final lightTheme = ThemeData(
    primaryColor: AppColors.white,
    accentColor: AppColors.blue,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.white,
        ),
        textTheme: TextTheme(
            caption: TextStyle(color: AppColors.charcoal, fontSize: 18))),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 75,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      headline2: TextStyle(
          fontSize: 65,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      headline3: TextStyle(
          fontSize: 55,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      headline4: TextStyle(
          fontSize: 45,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      headline5: TextStyle(
          fontSize: 35,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      headline6: TextStyle(
          fontSize: 25,
          letterSpacing: 2.0,
          color: AppColors.white,
          fontFamily: 'CastIron'),
      bodyText2: TextStyle(color: AppColors.white),
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

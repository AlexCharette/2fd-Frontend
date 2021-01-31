// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Confirmer mon absence`
  String get buttonAnswerNo {
    return Intl.message(
      'Confirmer mon absence',
      name: 'buttonAnswerNo',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer ma présence`
  String get buttonAnswerYes {
    return Intl.message(
      'Confirmer ma présence',
      name: 'buttonAnswerYes',
      desc: '',
      args: [],
    );
  }

  /// `J'ai oublié mon mot de passe`
  String get buttonForgotPassword {
    return Intl.message(
      'J\'ai oublié mon mot de passe',
      name: 'buttonForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Soumettre`
  String get buttonSubmit {
    return Intl.message(
      'Soumettre',
      name: 'buttonSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Erreure d'authentification`
  String get errorAuthenticationSubmission {
    return Intl.message(
      'Erreure d\'authentification',
      name: 'errorAuthenticationSubmission',
      desc: '',
      args: [],
    );
  }

  /// `Adresse courriel invalide`
  String get textFieldErrorEmail {
    return Intl.message(
      'Adresse courriel invalide',
      name: 'textFieldErrorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe invalide`
  String get textFieldErrorPassword {
    return Intl.message(
      'Mot de passe invalide',
      name: 'textFieldErrorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Adresse Courriel`
  String get textFieldHintEmail {
    return Intl.message(
      'Adresse Courriel',
      name: 'textFieldHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Pourquoi désirez-vous changer votre réponse?`
  String get textFieldHintReason {
    return Intl.message(
      'Pourquoi désirez-vous changer votre réponse?',
      name: 'textFieldHintReason',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe`
  String get textFieldHintPassword {
    return Intl.message(
      'Mot de Passe',
      name: 'textFieldHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Début`
  String get textFieldLabelVemStartDate {
    return Intl.message(
      'Début',
      name: 'textFieldLabelVemStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez donner un nom à cette VEM`
  String get textFieldValidatorVemName {
    return Intl.message(
      'Veuillez donner un nom à cette VEM',
      name: 'textFieldValidatorVemName',
      desc: '',
      args: [],
    );
  }

  /// `Portail Régimentaire`
  String get titleLogin {
    return Intl.message(
      'Portail Régimentaire',
      name: 'titleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Nouvelle VEM`
  String get titleNewVem {
    return Intl.message(
      'Nouvelle VEM',
      name: 'titleNewVem',
      desc: '',
      args: [],
    );
  }

  /// `2RAC`
  String get titleRegimentName {
    return Intl.message(
      '2RAC',
      name: 'titleRegimentName',
      desc: '',
      args: [],
    );
  }

  /// `Je désire changer ma réponse`
  String get titleRequestResponseChange {
    return Intl.message(
      'Je désire changer ma réponse',
      name: 'titleRequestResponseChange',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'CA'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'CA'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
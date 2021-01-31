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

  /// `Annuler`
  String get buttonCancel {
    return Intl.message(
      'Annuler',
      name: 'buttonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Annuler les changements`
  String get buttonCancelChanges {
    return Intl.message(
      'Annuler les changements',
      name: 'buttonCancelChanges',
      desc: '',
      args: [],
    );
  }

  /// `Modifier la VEM`
  String get buttonEditVem {
    return Intl.message(
      'Modifier la VEM',
      name: 'buttonEditVem',
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

  /// `Publier la VEM`
  String get buttonPublishVem {
    return Intl.message(
      'Publier la VEM',
      name: 'buttonPublishVem',
      desc: '',
      args: [],
    );
  }

  /// `Je veux changer ma réponse`
  String get buttonRequestResponseChange {
    return Intl.message(
      'Je veux changer ma réponse',
      name: 'buttonRequestResponseChange',
      desc: '',
      args: [],
    );
  }

  /// `Sauvegarder les changements`
  String get buttonSaveChanges {
    return Intl.message(
      'Sauvegarder les changements',
      name: 'buttonSaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Envoyer`
  String get buttonSend {
    return Intl.message(
      'Envoyer',
      name: 'buttonSend',
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

  /// `Un erreure s'est produite`
  String get errorGeneric {
    return Intl.message(
      'Un erreure s\'est produite',
      name: 'errorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Votre mot de passe n'a pas pu être modifié`
  String get errorResetPassword {
    return Intl.message(
      'Votre mot de passe n\'a pas pu être modifié',
      name: 'errorResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Adresse courriel invalide`
  String get inputErrorEmail {
    return Intl.message(
      'Adresse courriel invalide',
      name: 'inputErrorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe invalide`
  String get inputErrorPassword {
    return Intl.message(
      'Mot de passe invalide',
      name: 'inputErrorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Adresse Courriel`
  String get inputHintEmail {
    return Intl.message(
      'Adresse Courriel',
      name: 'inputHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Pourquoi désirez-vous changer votre réponse?`
  String get inputHintReason {
    return Intl.message(
      'Pourquoi désirez-vous changer votre réponse?',
      name: 'inputHintReason',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe`
  String get inputHintPassword {
    return Intl.message(
      'Mot de Passe',
      name: 'inputHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Fin`
  String get inputLabelVemEndDate {
    return Intl.message(
      'Fin',
      name: 'inputLabelVemEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Fermeture`
  String get inputLabelVemLockDate {
    return Intl.message(
      'Fermeture',
      name: 'inputLabelVemLockDate',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get inputLabelVemMaxParticipants {
    return Intl.message(
      'Maximum',
      name: 'inputLabelVemMaxParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get inputLabelVemMinParticipants {
    return Intl.message(
      'Minimum',
      name: 'inputLabelVemMinParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Type de Réponse`
  String get inputLabelVemResponseType {
    return Intl.message(
      'Type de Réponse',
      name: 'inputLabelVemResponseType',
      desc: '',
      args: [],
    );
  }

  /// `Début`
  String get inputLabelVemStartDate {
    return Intl.message(
      'Début',
      name: 'inputLabelVemStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez donner un nom à cette VEM`
  String get inputValidatorVemName {
    return Intl.message(
      'Veuillez donner un nom à cette VEM',
      name: 'inputValidatorVemName',
      desc: '',
      args: [],
    );
  }

  /// `Le minimum de participants doit être moins que le maximum.`
  String get inputValidatorParticipants {
    return Intl.message(
      'Le minimum de participants doit être moins que le maximum.',
      name: 'inputValidatorParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Entrez l'adresse courriel associée à votre compte`
  String get resetPasswordEmailInputDirections {
    return Intl.message(
      'Entrez l\'adresse courriel associée à votre compte',
      name: 'resetPasswordEmailInputDirections',
      desc: '',
      args: [],
    );
  }

  /// `La participation maximale pour cette VEM a été atteinte.`
  String get snackBarVemFull {
    return Intl.message(
      'La participation maximale pour cette VEM a été atteinte.',
      name: 'snackBarVemFull',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe Oublié`
  String get titleForgotPassword {
    return Intl.message(
      'Mot de Passe Oublié',
      name: 'titleForgotPassword',
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

  /// `Me déconnecter`
  String get titleLogout {
    return Intl.message(
      'Me déconnecter',
      name: 'titleLogout',
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

  /// `Mon Profile`
  String get titleProfile {
    return Intl.message(
      'Mon Profile',
      name: 'titleProfile',
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

  /// `VEMs`
  String get titleVemList {
    return Intl.message(
      'VEMs',
      name: 'titleVemList',
      desc: '',
      args: [],
    );
  }

  /// `Répondre à`
  String get titleVemResponder {
    return Intl.message(
      'Répondre à',
      name: 'titleVemResponder',
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
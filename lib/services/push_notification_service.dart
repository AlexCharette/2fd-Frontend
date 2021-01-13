import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging;

  PushNotificationService(this._firebaseMessaging);

  Future initialize() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true,
          provisional: true,
        ),
      );
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print('Settings registered: $settings');
      });
    }

    String token = await _firebaseMessaging.getToken();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        // If it's a vem, open the vem item responder
        // showDialog<bool>(
        //   context: context,
        //   builder: (context) => VemResponder(
        //     vemId: vem.id,
        //     vemName: vem.name,
        //   ),
        // );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        // If it's a vem, go to home and open the vem item responder
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        // If it's a vem, go to home and open the vem item responder
      },
    );
  }
}

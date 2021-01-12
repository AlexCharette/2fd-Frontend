import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging;

  PushNotificationService(this._firebaseMessaging);

  Future init() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    String token = await _firebaseMessaging.getToken();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:regimental_app/blocs/simple_bloc_observer.dart';
import 'package:regimental_app/config/theme.dart';

import 'package:user_repository/user_repository.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(
  //   (message) => _firebaseMessagingBackgroundHandler(message),
  // );
  Bloc.observer = SimpleBlocObserver();
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: App(
      authenticationRepository: AuthenticationRepository(),
      vemRepository: FirebaseVemRepository(),
      vemResponseRepository: FirebaseVemResponseRepository(),
      userRepository: FirebaseUserRepository(),
    ),
  ));
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Received a background message: ${message.messageId}');
// }

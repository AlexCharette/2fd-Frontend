import 'package:authentication_repository/authentication_repository.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:regimental_app/blocs/simple_bloc_observer.dart';
import 'package:regimental_app/config/theme.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: App(
      authenticationRepository: AuthenticationRepository(),
      vemRepository: FirebaseVemRepository(),
      vemResponseRepository: FirebaseVemResponseRepository(),
    ),
  ));
}

import 'package:flutter/widgets.dart';
import 'package:regimental_app/repos/authentication_repository.dart';
import 'package:regimental_app/repos/user_repository.dart';

import 'app.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

import 'package:flutter_login/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/repos/authentication_repository.dart';
import 'package:flutter_login/repos/user_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

import 'dart:async';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<void> authenticate();

  Future<String> getUserId();

  Stream<User> getUserData(String uid);
}

import 'dart:async';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<void> authenticate();

  Future<void> updateUser(User user);

  Future<String> getUserId();

  Stream<User> currentUser();

  Stream<List<User>> users();
}

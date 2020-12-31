import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

import 'models/models.dart';

class LogInWithEmailAndPasswordFailure implements Exception{}
class LogOutFailure implements Exception{}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepository({ firebase_auth.FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<User> get user{
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      return firebaseUser == null
          ? User.empty
          : User(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName);
    });
  }
  Future logInWithEmailAndPassword({@required String username, @required String password,}) async {
    assert(username != null && password != null);
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async{
    try{
      await _firebaseAuth.signOut();
    } on Exception{
      throw LogOutFailure();
    }
  }
  void requestOneTimeCode({@required String username}) async{}
}

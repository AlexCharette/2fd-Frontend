import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:user_repository/user_repository.dart';

// import '../user_repository.dart';
import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final auth.FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> getUserId() async {
    return _firebaseAuth.currentUser.uid;
  }

  @override
  Stream<User> getUserData(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      UserEntity userEntity = UserEntity.fromSnapshot(snapshot);
      switch (userEntity.accountType) {
        case 'normal':
          return NormalMember.fromEntity(userEntity);
        case 'command':
          return CommandMember.fromEntity(userEntity);
        case 'detCommand':
          return DetCommandMember.fromEntity(userEntity);
        default:
          throw "Invalid account type: ${userEntity.accountType}";
      }
    });
  }
}

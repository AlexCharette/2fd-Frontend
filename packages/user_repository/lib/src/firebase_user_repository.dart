import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:user_repository/user_repository.dart';

// import '../user_repository.dart';
import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final auth.FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<void> updateUser(User update) {
    return userCollection.doc(update.id).update(update.toEntity().toDocument());
  }

  @override
  Future<String> getUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Stream<User> currentUser() {
    try {
      return userCollection
          .doc(_firebaseAuth.currentUser?.uid)
          .snapshots()
          .map((snapshot) {
        UserEntity userEntity = UserEntity.fromSnapshot(snapshot);
        switch (userEntity.accountType) {
          case AccountType.normal:
            return NormalMember.fromEntity(userEntity);
          case AccountType.command:
            return CommandMember.fromEntity(userEntity);
          case AccountType.detCommand:
            return DetCommandMember.fromEntity(userEntity);
          default:
            throw 'Invalid account type: ${userEntity.accountType}';
        }
      });
    } catch (exception) {
      print('Could not load current user: $exception');
    }
  }

  @override
  Stream<List<User>> users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        switch (doc.get('accountType')) {
          case 'normal':
            return NormalMember.fromEntity(UserEntity.fromSnapshot(doc));
          case 'detCommand':
            return DetCommandMember.fromEntity(UserEntity.fromSnapshot(doc));
          case 'command':
            return CommandMember.fromEntity(UserEntity.fromSnapshot(doc));
          default:
            throw 'Invalid account type: ${doc.get('accountType')}';
        }
      }).toList();
    });
  }
}

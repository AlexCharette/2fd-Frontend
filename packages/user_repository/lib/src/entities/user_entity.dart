import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String phoneNumber;
  final String rank;
  final String lastName;
  final int lastThree;
  final String status;
  final String accountType;

  const UserEntity();

  Map<String, Object> toJson() {
    return {
      "email": email,
    };
  }

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return """
      User{}""";
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["id"] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.id,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
    };
  }
}

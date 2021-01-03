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

  const UserEntity(this.id, this.email, this.phoneNumber, this.lastName,
      this.lastThree, this.rank, this.status,
      {String accountType})
      : assert(accountType == 'normal' ||
            accountType == 'detCommand' ||
            accountType == 'command'),
        this.accountType = accountType;

  @override
  List<Object> get props => [
        email,
        phoneNumber,
        lastName,
        lastThree,
        rank,
        status,
        accountType,
        id,
      ];

  @override
  String toString() {
    return """
      User{
        email: $email, phoneNumber: $phoneNumber, 
        lastName: $lastName, lastThree: $lastThree, rank: $rank, 
        status: $status, accountType: $accountType
      }
    """;
  }

  Map<String, Object> toJson() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "lastName": lastName,
      "lastThree": lastThree,
      "rank": rank,
      "status": status,
      "accountType": accountType,
      "id": id,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["id"] as String,
      json["email"] as String,
      json["phoneNumber"] as String,
      json["lastName"] as String,
      json["lastThree"] as int,
      json["rank"] as String,
      json["status"] as String,
      accountType: json["accountType"] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.id,
      snap.get('email'),
      snap.get('phoneNumber'),
      snap.get('lastName'),
      snap.get('lastThree'),
      snap.get('rank'),
      snap.get('status'),
      accountType: snap.get('accountType'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "lastName": lastName,
      "lastThree": lastThree,
      "rank": rank,
      "status": status,
      "accountType": accountType,
    };
  }
}

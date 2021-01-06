import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String phoneNumber;
  final String rank;
  final String lastName;
  final int lastThree;
  final MemberStatus status;
  final AccountType accountType;

  const UserEntity(this.id, this.email, this.phoneNumber, this.lastName,
      this.lastThree, this.rank, this.status,
      {AccountType accountType})
      : assert(accountType is AccountType),
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
        status: ${status.toString()}, accountType: ${accountType.toString()}
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
      "status": status.toString(),
      "accountType": accountType.toString(),
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
      MemberStatus.values.firstWhere((element) => element.toString() == json["status"] as String),
      accountType: AccountType.values.firstWhere((element) => element.toString() == json["accountType"] as String),
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
      MemberStatus.values.firstWhere((element) => element.toString() == snap.get('status')),
      accountType: AccountType.values.firstWhere((element) => element.toString() == snap.get('accountType')) ,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "lastName": lastName,
      "lastThree": lastThree,
      "rank": rank,
      "status": status.toString(),
      "accountType": accountType.toString(),
    };
  }
}

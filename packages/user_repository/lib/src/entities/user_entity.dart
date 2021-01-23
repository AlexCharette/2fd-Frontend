import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String phoneNumber;
  final String initials;
  final String detId;
  final MemberStatus status;
  final AccountType accountType;

  const UserEntity(this.id, this.email, this.phoneNumber, this.initials,
      this.detId, this.status,
      {AccountType accountType})
      : assert(accountType is AccountType),
        this.accountType = accountType;

  @override
  List<Object> get props => [
        email,
        phoneNumber,
        initials,
        status,
        accountType,
        detId,
        id,
      ];

  @override
  String toString() {
    return """
      User{
        email: $email, phoneNumber: $phoneNumber, 
        initials: $initials, detId: $detId, status: ${status.toString()}, 
        accountType: ${accountType.toString()}
      }
    """;
  }

  Map<String, Object> toJson() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "initials": initials,
      "detId": detId,
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
      json["initials"] as String,
      json["detId"] as String,
      MemberStatus.values.firstWhere(
          (element) => element.toString() == json["status"] as String,
          orElse: () => MemberStatus.active),
      accountType: AccountType.values.firstWhere(
          (element) => element.toString() == json["accountType"] as String,
          orElse: () => AccountType.normal),
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.id,
      snap.get('email'),
      snap.get('phoneNumber'),
      snap.get('initials'),
      snap.get('detId'),
      MemberStatus.values.firstWhere(
          (element) =>
              element.toString() == 'MemberStatus.' + snap.get('status'),
          orElse: () => MemberStatus.active),
      accountType: AccountType.values.firstWhere(
          (element) =>
              element.toString() == 'AccountType.' + snap.get('accountType'),
          orElse: () => AccountType.normal),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "initials": initials,
      "detId": detId,
      "status": status.toString(),
      "accountType": accountType.toString(),
    };
  }
}

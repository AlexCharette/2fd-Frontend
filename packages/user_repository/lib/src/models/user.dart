import 'package:meta/meta.dart';
import '../entities/entities.dart';

enum MemberStatus { active, nonActive, nonPaidLeave }
enum AccountType { normal, detCommand, command }

@immutable
abstract class User {
  final String id;
  final String email;
  final String phoneNumber;
  final String lastName;
  final int lastThree;
  final String rank;
  final MemberStatus status;

  User(
    this.email,
    this.lastName,
    this.lastThree,
    this.rank, {
    String phoneNumber = '',
    MemberStatus status = MemberStatus.active,
    String id,
  })  : this.phoneNumber = phoneNumber,
        this.status = status,
        this.id = id;

  User copyWith({
    String id,
    String email,
    String phoneNumber,
    String lastName,
    int lastThree,
    String rank,
    MemberStatus status,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      lastName.hashCode ^
      lastThree.hashCode ^
      rank.hashCode ^
      status.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType;

  UserEntity toEntity();
}

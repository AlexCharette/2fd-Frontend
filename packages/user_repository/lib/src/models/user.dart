import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
abstract class User {
  final String id;
  final String email;
  final String phoneNumber;
  final String lastName;
  final int lastThree;
  final String rank;
  final String status;

  User(
    this.email,
    this.lastName,
    this.lastThree,
    this.rank, {
    String phoneNumber = '',
    String status = 'active',
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
    String status,
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

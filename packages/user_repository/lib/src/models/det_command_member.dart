import 'package:meta/meta.dart';
import 'models.dart';
import '../entities/entities.dart';

@immutable
class DetCommandMember extends User {
  DetCommandMember(
    String email,
    String initials,
    String detId, {
    String phoneNumber = '',
    MemberStatus status = MemberStatus.active,
    String id,
  }) : super(
          email,
          initials,
          detId,
          phoneNumber: phoneNumber,
          status: status,
          id: id,
        );

  DetCommandMember copyWith({
    String id,
    String detId,
    String email,
    String phoneNumber,
    String initials,
    MemberStatus status,
  }) {
    return DetCommandMember(
      email ?? this.email,
      initials ?? this.initials,
      detId ?? this.detId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      detId.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      initials.hashCode ^
      status.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType;

  UserEntity toEntity() {
    return UserEntity(
      id,
      email,
      phoneNumber,
      initials,
      detId,
      status,
      accountType: AccountType.detCommand,
    );
  }

  static DetCommandMember fromEntity(UserEntity entity) {
    return DetCommandMember(
      entity.email,
      entity.initials,
      entity.detId,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      id: entity.id,
    );
  }
}

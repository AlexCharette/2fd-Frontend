import 'package:meta/meta.dart';
import 'models.dart';
import '../entities/entities.dart';

@immutable
class CommandMember extends User {
  CommandMember(
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

  CommandMember copyWith({
    String id,
    String email,
    String phoneNumber,
    String initials,
    String detId,
    MemberStatus status,
  }) {
    return CommandMember(
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
      accountType: AccountType.command,
    );
  }

  static CommandMember fromEntity(UserEntity entity) {
    return CommandMember(
      entity.email,
      entity.initials,
      entity.detId,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      id: entity.id,
    );
  }
}

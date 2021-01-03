import 'models.dart';
import '../entities/entities.dart';

@immutable
class CommandMember extends User {
  static CommandMember fromEntity(UserEntity entity) {
    return CommandMember(
      entity.email,
      entity.lastName,
      entity.lastThree,
      entity.rank,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      id: entity.id,
    );
  }
}

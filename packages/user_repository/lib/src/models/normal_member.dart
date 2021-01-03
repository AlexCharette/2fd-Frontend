import 'models.dart';
import '../entities/entities.dart';

@immutable
class NormalMember extends User {
  static NormalMember fromEntity(UserEntity entity) {
    return NormalMember(
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

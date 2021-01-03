import 'models.dart';
import '../entities/entities.dart';

@immutable
class DetCommandMember extends User {
  static DetCommandMember fromEntity(UserEntity entity) {
    return DetCommandMember(
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

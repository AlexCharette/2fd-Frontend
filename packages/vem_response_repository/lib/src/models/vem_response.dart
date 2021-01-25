import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class VemResponse {
  final String id;
  final String userId;
  final String vemId;
  final String answer;

  VemResponse(this.userId, this.vemId, this.answer, {String id}) : this.id = id;

  VemResponse copyWith(
      {String id, String userId, String vemId, String answer}) {
    return VemResponse(
      userId ?? this.userId,
      vemId ?? this.vemId,
      answer ?? this.answer,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ vemId.hashCode ^ answer.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VemResponse &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          vemId == other.vemId &&
          answer == other.answer &&
          id == other.id;

  VemResponseEntity toEntity() {
    return VemResponseEntity(id, userId, vemId, answer: answer);
  }

  static VemResponse fromEntity(VemResponseEntity entity) {
    return VemResponse(
      entity.userId,
      entity.vemId,
      entity.answer,
      id: entity.id,
    );
  }
}

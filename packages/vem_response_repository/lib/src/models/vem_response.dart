import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class VemResponse {
  final String id;
  final String userId;
  final String userInitials;
  final String vemId;
  final String detName;
  final String answer;

  VemResponse(
      this.userId, this.userInitials, this.vemId, this.detName, this.answer,
      {String id})
      : this.id = id;

  VemResponse copyWith(
      {String id,
      String userId,
      String userInitials,
      String vemId,
      String detName,
      String answer}) {
    return VemResponse(
      userId ?? this.userId,
      userInitials ?? this.userInitials,
      vemId ?? this.vemId,
      detName ?? this.detName,
      answer ?? this.answer,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      userInitials.hashCode ^
      vemId.hashCode ^
      detName.hashCode ^
      answer.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VemResponse &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          userInitials == other.userInitials &&
          vemId == other.vemId &&
          detName == other.detName &&
          answer == other.answer &&
          id == other.id;

  VemResponseEntity toEntity() {
    return VemResponseEntity(id, userId, userInitials, vemId, detName,
        answer: answer);
  }

  static VemResponse fromEntity(VemResponseEntity entity) {
    return VemResponse(
      entity.userId,
      entity.userInitials,
      entity.vemId,
      entity.detName,
      entity.answer,
      id: entity.id,
    );
  }
}

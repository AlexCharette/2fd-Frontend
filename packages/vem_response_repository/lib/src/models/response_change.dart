import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class ResponseChange {
  final String id;
  final String detId;
  final String userId;
  final String responseId;
  final String newAnswer;
  final String reason;
  final bool approved;

  ResponseChange(
      this.detId, this.userId, this.responseId, this.newAnswer, this.reason,
      {String id, bool approved = false})
      : this.id = id,
        this.approved = approved;

  ResponseChange copyWith(
      {String id,
      String detId,
      String userId,
      String responseId,
      String newAnswer,
      String reason,
      bool approved}) {
    return ResponseChange(
      detId ?? this.detId,
      userId ?? this.userId,
      responseId ?? this.responseId,
      newAnswer ?? this.newAnswer,
      reason ?? this.reason,
      approved: approved ?? this.approved,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      detId.hashCode ^
      userId.hashCode ^
      responseId.hashCode ^
      newAnswer.hashCode ^
      reason.hashCode ^
      approved.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseChange && runtimeType == other.runtimeType;

  ResponseChangeEntity toEntity() {
    return ResponseChangeEntity(
      id,
      detId,
      userId,
      responseId,
      newAnswer,
      reason,
      approved: approved,
    );
  }

  static ResponseChange fromEntity(ResponseChangeEntity entity) {
    return ResponseChange(
      entity.detId,
      entity.userId,
      entity.responseId,
      entity.newAnswer,
      entity.reason,
      id: entity.id,
      approved: entity.approved,
    );
  }
}

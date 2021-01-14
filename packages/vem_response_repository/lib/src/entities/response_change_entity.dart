import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ResponseChangeEntity extends Equatable {
  final String id;
  final String detId;
  final String userId;
  final String responseId;
  final String newAnswer;
  final String reason;
  final bool approved;

  const ResponseChangeEntity(this.id, this.detId, this.userId, this.responseId,
      this.newAnswer, this.reason,
      {bool approved = false})
      : this.approved = approved;

  Map<String, Object> toJson() {
    return {
      "detId": detId,
      "userId": userId,
      "responseId": responseId,
      "newAnswer": newAnswer,
      "reason": reason,
      "approved": approved,
      "id": id,
    };
  }

  @override
  List<Object> get props => [
        detId,
        userId,
        responseId,
        newAnswer,
        reason,
        approved,
        id,
      ];

  @override
  String toString() {
    return """
      ResponseChange{detId: $detId, userId: $userId, responseId: $responseId, 
      newAnswer: $newAnswer, reason: $reason, approved: $approved, id: $id}
    """;
  }

  static ResponseChangeEntity fromJson(Map<String, Object> json) {
    return ResponseChangeEntity(
      json["id"] as String,
      json["detId"] as String,
      json["userId"] as String,
      json["responseId"] as String,
      json["newAnswer"] as String,
      json["reason"] as String,
      approved: json["approved"] as bool,
    );
  }

  static ResponseChangeEntity fromSnapshot(DocumentSnapshot snap) {
    return ResponseChangeEntity(
      snap.id,
      snap.get('detId'),
      snap.get('userId'),
      snap.get('responseId'),
      snap.get('newAnswer'),
      snap.get('reason'),
      approved: snap.get('approved'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "detId": detId,
      "userId": userId,
      "responseId": responseId,
      "newAnswer": newAnswer,
      "reason": reason,
      "approved": approved,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VemResponseEntity extends Equatable {
  final String id;
  final String userId;
  final String vemId;
  final String answer;

  const VemResponseEntity(this.id, this.userId, this.vemId,
      {String answer = 'seen'})
      : assert(answer == 'yes' || answer == 'no' || answer == 'seen'),
        this.answer = answer;

  Map<String, Object> toJson() {
    return {
      "userId": userId,
      "vemId": vemId,
      "answer": answer,
      "id": id,
    };
  }

  @override
  List<Object> get props => [userId, vemId, answer, id];

  @override
  String toString() {
    return 'VemResponse{userId: $userId, vemId: $vemId, answer: $answer, id: $id}';
  }

  static VemResponseEntity fromJson(Map<String, Object> json) {
    return VemResponseEntity(
      json["id"] as String,
      json["userId"] as String,
      json["vemId"] as String,
      answer: json["answer"] as String,
    );
  }

  static VemResponseEntity fromSnapshot(DocumentSnapshot snap) {
    return VemResponseEntity(
      snap.id,
      snap.get('userId'),
      snap.get('vemId'),
      answer: snap.get('answer'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "userId": userId,
      "vemId": vemId,
      "answer": answer,
    };
  }
}

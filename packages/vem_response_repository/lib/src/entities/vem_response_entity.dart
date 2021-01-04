import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VemResponseEntity extends Equatable {
  final String id;
  final DocumentReference member;
  final String answer;

  const VemResponseEntity(this.id, this.member, {String answer = 'seen'})
      : assert(answer == 'yes' || answer == 'no' || answer == 'seen'),
        this.answer = answer;

  Map<String, Object> toJson() {
    return {
      "member": member,
      "answer": answer,
      "id": id,
    };
  }

  @override
  List<Object> get props => [member, answer, id];

  @override
  String toString() {
    return 'VemResponse{member: $member, answer: $answer, id: $id}';
  }

  static VemResponseEntity fromJson(Map<String, Object> json) {
    return VemResponseEntity(
      json["id"] as String,
      json["member"] as DocumentReference,
      answer: json["answer"] as String,
    );
  }

  static VemResponseEntity fromSnapshot(DocumentSnapshot snap) {
    return VemResponseEntity(
      snap.id,
      snap.get('member'),
      answer: snap.get('answer'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "member": member,
      "answer": answer,
    };
  }
}

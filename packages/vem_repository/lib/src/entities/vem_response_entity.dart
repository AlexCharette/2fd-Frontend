import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VemResponseEntity extends Equatable {
  final String id;
  final DocumentReference member;
  final String answer;

  const VemResponseEntity(
    this.id,
    this.member,
    this.answer,
  );

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
      json["answer"] as String,
    );
  }

  static VemResponseEntity fromSnapshot(DocumentSnapshot snap) {
    return VemResponseEntity(
      snap.id,
      snap.get('member'),
      snap.get('answer'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "member": member,
      "answer": answer,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class VemResponse {
  final String id;
  final DocumentReference member;
  final String answer;

  VemResponse(this.member, this.answer, {String id}) : this.id = id;

  VemResponse copyWith({String id, DocumentReference member, String answer}) {
    return VemResponse(
      member ?? this.member,
      answer ?? this.answer,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode => id.hashCode ^ member.hashCode ^ answer.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VemResponse && runtimeType == other.runtimeType;

  VemResponseEntity toEntity() {
    return VemResponseEntity(id, member, answer);
  }

  static VemResponse fromEntity(VemResponseEntity entity) {
    return VemResponse(entity.member, entity.answer, id: entity.id);
  }
}

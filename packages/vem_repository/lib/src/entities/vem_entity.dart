import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VemEntity extends Equatable {
  final String id;
  final String name;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp lockDate;
  final String responseType;
  final String description;
  final int minParticipants;
  final int maxParticipants;

  const VemEntity(
      this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.lockDate,
      this.responseType,
      this.description,
      this.minParticipants,
      this.maxParticipants);

  Map<String, Object> toJson() {
    return {
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "lockDate": lockDate,
      "responseType": responseType,
      "description": description,
      "minParticipants": minParticipants,
      "maxParticipants": maxParticipants,
      "id": id,
    };
  }

  @override
  List<Object> get props => [
        name,
        startDate,
        endDate,
        lockDate,
        responseType,
        description,
        minParticipants,
        maxParticipants,
        id
      ];

  @override
  String toString() {
    return """
      Vem{
        name: $name, startDate: $startDate, endDate: $endDate, 
        lockDate: $lockDate, responseType: $responseType, 
        description: $description, minParticipants: $minParticipants,
        maxParticipants: $maxParticipants, id: $id
      }
    """;
  }

  static VemEntity fromJson(Map<String, Object> json) {
    return VemEntity(
      json["id"] as String,
      json["name"] as String,
      json["startDate"] as Timestamp,
      json["endDate"] as Timestamp,
      json["lockDate"] as Timestamp,
      json["responseType"] as String,
      json["description"] as String,
      json["minParticipants"] as int,
      json["maxParticipants"] as int,
    );
  }

  static VemEntity fromSnapshot(DocumentSnapshot snap) {
    return VemEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['startDate'],
      snap.data['endDate'],
      snap.data['lockDate'],
      snap.data['responseType'],
      snap.data['description'],
      snap.data['minParticipants'],
      snap.data['maxParticipants'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "lockDate": lockDate,
      "responseType": responseType,
      "description": description,
      "minParticipants": minParticipants,
      "maxParticipants": maxParticipants,
    };
  }
}

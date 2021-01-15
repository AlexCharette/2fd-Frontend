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
  final int numParticipants;

  const VemEntity(
      this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.lockDate,
      this.description,
      this.minParticipants,
      this.maxParticipants,
      this.numParticipants,
      {String responseType})
      : assert(responseType == 'battery' || responseType == 'other'),
        this.responseType = responseType;

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
        numParticipants,
        id
      ];

  @override
  String toString() {
    return """
      Vem{
        name: $name, startDate: $startDate, endDate: $endDate, 
        lockDate: $lockDate, responseType: $responseType, 
        description: $description, minParticipants: $minParticipants,
        maxParticipants: $maxParticipants, numParticipants: $numParticipants, id: $id
      }
    """;
  }

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
      "numParticipants": numParticipants,
      "id": id,
    };
  }

  static VemEntity fromJson(Map<String, Object> json) {
    return VemEntity(
      json["id"] as String,
      json["name"] as String,
      json["startDate"] as Timestamp,
      json["endDate"] as Timestamp,
      json["lockDate"] as Timestamp,
      json["description"] as String,
      json["minParticipants"] as int,
      json["maxParticipants"] as int,
      json["numParticipants"] as int,
      responseType: json["responseType"] as String,
    );
  }

  static VemEntity fromSnapshot(DocumentSnapshot snap) {
    return VemEntity(
      snap.id,
      snap.get('name'),
      snap.get('startDate'),
      snap.get('endDate'),
      snap.get('lockDate'),
      snap.get('description'),
      snap.get('minParticipants'),
      snap.get('maxParticipants'),
      snap.get('numParticipants'),
      responseType: snap.get('responseType'),
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
      "numParticipants": numParticipants,
    };
  }
}

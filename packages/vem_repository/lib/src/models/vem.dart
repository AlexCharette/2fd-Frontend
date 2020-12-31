import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Vem {
  final String id;
  final String name;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp lockDate;
  final String responseType;
  final String description;
  final int minParticipants;
  final int maxParticipants;

  Vem(
    this.name, {
    String description,
    String responseType,
    Timestamp startDate,
    Timestamp endDate,
    Timestamp lockDate,
    int minParticipants = 0,
    int maxParticipants = 999,
    String id,
  })  : this.description = description ?? '',
        this.responseType = responseType, // TODO validate
        this.startDate = startDate ?? getDefaultStartDate(),
        this.endDate = endDate ?? getDefaultEndDate(),
        this.lockDate = lockDate ?? getDefaultLockDate(),
        this.minParticipants = minParticipants,
        this.maxParticipants = maxParticipants,
        this.id = id;

  Vem copyWith({
    String id,
    String name,
    String description,
    String responseType,
    Timestamp startDate,
    Timestamp endDate,
    Timestamp lockDate,
    int minParticipants,
    int maxParticipants,
  }) {
    return Vem(
      name ?? this.name,
      description: description ?? this.description,
      responseType: responseType ?? this.responseType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lockDate: lockDate ?? this.lockDate,
      minParticipants: minParticipants ?? this.minParticipants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      lockDate.hashCode ^
      responseType.hashCode ^
      description.hashCode ^
      minParticipants.hashCode ^
      maxParticipants.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vem && runtimeType == other.runtimeType;

  VemEntity toEntity() {
    return VemEntity(id, name, startDate, endDate, lockDate,
        responseType.toString(), description, minParticipants, maxParticipants);
  }

  static Vem fromEntity(VemEntity entity) {
    return Vem(
      entity.name,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      lockDate: entity.lockDate,
      responseType: entity.responseType,
      minParticipants: entity.minParticipants,
      maxParticipants: entity.maxParticipants,
      id: entity.id,
    );
  }

  static Timestamp getDefaultStartDate() {
    DateTime now = DateTime.now();
    DateTime startDate = now.add(new Duration(days: 7));
    int startDay = startDate.day;
    int startMonth = startDate.month;
    int startYear = startDate.year;
    return Timestamp.fromDate(DateTime(startYear, startMonth, startDay, 8));
  }

  static Timestamp getDefaultEndDate() {
    DateTime now = DateTime.now();
    DateTime endDate = now.add(new Duration(days: 7));
    int endDay = endDate.day;
    int endMonth = endDate.month;
    int endYear = endDate.year;
    return Timestamp.fromDate(DateTime(endYear, endMonth, endDay, 17));
  }

  static Timestamp getDefaultLockDate() {
    DateTime now = DateTime.now();
    DateTime lockDate = now.add(new Duration(days: 3));
    return Timestamp.fromDate(
        DateTime(lockDate.year, lockDate.month, lockDate.day, 23, 59));
  }
}

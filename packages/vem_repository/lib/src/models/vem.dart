import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
  final int numParticipants;

  Vem(
    this.name,
    this.responseType, {
    String description,
    Timestamp startDate,
    Timestamp endDate,
    Timestamp lockDate,
    int minParticipants = 0,
    int maxParticipants = 999,
    int numParticipants = 0,
    String id,
  })  : this.description = description ?? '',
        this.startDate = startDate ?? getDefaultStartDate(),
        this.endDate = endDate ?? getDefaultEndDate(),
        this.lockDate = lockDate ?? getDefaultLockDate(),
        this.minParticipants = minParticipants,
        this.maxParticipants = maxParticipants,
        this.numParticipants = numParticipants,
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
    int numParticipants,
  }) {
    return Vem(
      name ?? this.name,
      responseType ?? this.responseType,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lockDate: lockDate ?? this.lockDate,
      minParticipants: minParticipants ?? this.minParticipants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      numParticipants: numParticipants ?? this.numParticipants,
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
      maxParticipants.hashCode ^
      numParticipants.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          lockDate == other.lockDate &&
          description == other.description &&
          responseType == other.responseType &&
          minParticipants == other.minParticipants &&
          maxParticipants == other.maxParticipants &&
          numParticipants == other.numParticipants &&
          id == other.id;

  VemEntity toEntity() {
    return VemEntity(
      id,
      name,
      startDate,
      endDate,
      lockDate,
      description,
      minParticipants,
      maxParticipants,
      numParticipants,
      responseType: responseType,
    );
  }

  static Vem fromEntity(VemEntity entity) {
    return Vem(
      entity.name,
      entity.responseType,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      lockDate: entity.lockDate,
      minParticipants: entity.minParticipants,
      maxParticipants: entity.maxParticipants,
      numParticipants: entity.numParticipants,
      id: entity.id,
    );
  }

  bool isFull() {
    return (numParticipants >= maxParticipants);
  }

  bool isLocked() {
    return !(Timestamp.now().compareTo(lockDate) <= 0);
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

  static String timestampToYearMonthDay(Timestamp timestamp) {
    DateTime myDateTime = timestamp.toDate();

    return DateFormat.yMd().format(myDateTime);
  }

  static String timestampToYearMonthDayTime(Timestamp timestamp) {
    DateTime myDateTime = timestamp.toDate();

    return DateFormat.yMd().add_Hm().format(myDateTime);
  }
}

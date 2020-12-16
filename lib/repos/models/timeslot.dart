import 'package:equatable/equatable.dart';

class Timeslot extends Equatable {
  Timeslot(this.date, this.user, this.isAvailable);

  final DateTime date;
  final String user;
  final bool isAvailable;

  int get day => date.day;

  int get time => date.hour;

  @override
  List<Object> get props => [date, user, isAvailable];
}

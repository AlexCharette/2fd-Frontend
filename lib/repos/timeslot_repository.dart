import 'dart:async';

import 'package:uuid/uuid.dart';

import 'models/models.dart';

class TimeslotRepository {
  Timeslot _timeslot;

  Future<Timeslot> getTimeslot() async {
    if (_timeslot != null) return _timeslot;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _timeslot = Timeslot(DateTime.now(), Uuid().v4(), true),
    );
  }
}

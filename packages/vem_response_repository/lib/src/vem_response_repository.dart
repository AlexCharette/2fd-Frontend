import 'dart:async';
import 'package:vem_response_repository/src/models/response_change.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

abstract class VemResponseRepository {
  Future<void> addVemResponse(VemResponse response);

  Future<void> updateVemResponse(VemResponse response);

  Stream<List<VemResponse>> vemResponses();

  Stream<List<VemResponse>> responsesForVem(String vemId);

  Stream<Map<String, Stream<List<VemResponse>>>> groupedVemResponses();

  Future<void> addResponseChange(ResponseChange change);

  Future<void> updateResponseChange(ResponseChange change);
}

import 'dart:async';
import 'package:vem_response_repository/vem_response_repository.dart';

abstract class VemResponseRepository {
  Future<void> addVemResponse(String vemId, VemResponse response);

  Future<void> updateVemResponse(String vemId, VemResponse response);

  Stream<List<VemResponse>> vemResponses();

  Stream<Map<String, List<VemResponse>>> groupedVemResponses();
}

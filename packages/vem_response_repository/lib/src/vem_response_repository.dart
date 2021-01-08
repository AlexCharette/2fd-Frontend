import 'dart:async';
import 'package:vem_response_repository/vem_response_repository.dart';

abstract class VemResponseRepository {
  Future<void> addVemResponse(VemResponse response);

  Future<void> updateVemResponse(VemResponse response);

  Stream<List<VemResponse>> vemResponses();

  Stream<Map<String, Stream<List<VemResponse>>>> groupedVemResponses();
}

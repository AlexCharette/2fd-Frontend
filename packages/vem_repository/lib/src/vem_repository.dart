import 'dart:async';
import 'package:vem_repository/vem_repository.dart';

abstract class VemRepository {
  Future<void> addNewVem(Vem vem);

  Future<void> deleteVem(Vem vem);

  Stream<List<Vem>> vems();

  Future<void> updateVem(Vem vem);

  Future<void> addVemResponse(String vemId, VemResponse response);

  Future<void> updateVemResponse(String vemId, VemResponse response);

  Stream<List<VemResponse>> vemResponses();
}

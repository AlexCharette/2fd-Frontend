import 'dart:async';
import 'package:vem_repository/vem_repository.dart';

abstract class VemRepository {
  Future<void> addNewVem(Vem vem);

  Future<void> deleteVem(Vem vem);

  Stream<List<Vem>> vems();

  Future<void> updateVem(Vem vem);
}

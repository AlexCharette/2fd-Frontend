import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_repository/vem_repository.dart';
import 'entities/entities.dart';

class FirebaseVemRepository implements VemRepository {
  final vemCollection = Firestore.instance.collection('vem');

  @override
  Future<void> addNewVem(Vem vem) {
    return vemCollection.add(vem.toEntity().toDocument());
  }

  @override
  Future<void> deleteVem(Vem vem) async {
    return vemCollection.document(vem.id).delete();
  }

  @override
  Stream<List<Vem>> vems() {
    return vemCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Vem.fromEntity(VemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateVem(Vem update) {
    return vemCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}

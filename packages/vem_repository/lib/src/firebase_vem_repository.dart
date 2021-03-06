import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_repository/vem_repository.dart';
import 'entities/entities.dart';

class FirebaseVemRepository implements VemRepository {
  final vemCollection = FirebaseFirestore.instance.collection('vems');

  @override
  Future<void> addNewVem(Vem vem) {
    return vemCollection.add(vem.toEntity().toDocument());
  }

  @override
  Future<void> deleteVem(Vem vem) async {
    return vemCollection.doc(vem.id).delete();
  }

  @override
  Stream<List<Vem>> vems() {
    return vemCollection
        .where("endDate", isGreaterThanOrEqualTo: Timestamp.now())
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Vem.fromEntity(VemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateVem(Vem update) {
    return vemCollection.doc(update.id).update(update.toEntity().toDocument());
  }
}

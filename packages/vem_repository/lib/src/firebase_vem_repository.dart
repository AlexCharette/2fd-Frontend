import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_repository/vem_repository.dart';
import 'entities/entities.dart';

class FirebaseVemRepository implements VemRepository {
  final vemCollection = FirebaseFirestore.instance.collection('vems');
  final vemResponseCollection =
      FirebaseFirestore.instance.collectionGroup('responses');

  Future<CollectionReference> _getCollection() async {
    var snapshot = await FirebaseFirestore.instance.collection('vems');
  }

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
    Query query =
        vemCollection.where("endDate", isGreaterThanOrEqualTo: Timestamp.now());
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

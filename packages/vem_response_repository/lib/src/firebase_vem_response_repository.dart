import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'entities/entities.dart';

class FirebaseVemResponseRepository implements VemResponseRepository {
  final vemCollection = FirebaseFirestore.instance.collection('vems');
  final vemResponseCollection =
      FirebaseFirestore.instance.collectionGroup('responses');

  @override
  Future<void> addVemResponse(String vemId, VemResponse response) {
    return vemCollection
        .doc(vemId)
        .collection('responses')
        .add(response.toEntity().toDocument());
  }

  @override
  Future<void> updateVemResponse(String vemId, VemResponse response) {
    return vemCollection
        .doc(vemId)
        .collection('responses')
        .doc(response.id)
        .update(response.toEntity().toDocument());
  }

  @override
  Stream<List<VemResponse>> vemResponses() {
    return vemResponseCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              VemResponse.fromEntity(VemResponseEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<Map<String, List<VemResponse>>> groupedVemResponses() async* {
    // Build map
    Map<String, List<VemResponse>> vemResponses;
    // Then iterate over it and yield
    vemCollection.snapshots().map((vemSnapshot) {
      return vemSnapshot.docs.map((doc) => vemResponses['${doc.id}'] = doc
          .reference
          .collection('responses')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) =>
              VemResponse.fromEntity(VemResponseEntity.fromSnapshot(doc))))
          .toList() as List<VemResponse>);
    });
    yield vemResponses;
  }
}

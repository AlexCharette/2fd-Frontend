import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'entities/entities.dart';

class FirebaseVemResponseRepository implements VemResponseRepository {
  final responseChangeCollection =
      FirebaseFirestore.instance.collection('responseChanges');
  final vemResponseCollection =
      FirebaseFirestore.instance.collection('responses');

  @override
  Future<void> addVemResponse(VemResponse response) {
    return vemResponseCollection.add(response.toEntity().toDocument());
  }

  @override
  Future<void> updateVemResponse(VemResponse response) {
    return vemResponseCollection
        .doc(response.id)
        .update(response.toEntity().toDocument());
  }

  @override
  Stream<List<VemResponse>> vemResponses() {
    return vemResponseCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            VemResponse.fromEntity(VemResponseEntity.fromSnapshot(doc)))
        .toList());
  }

  @override
  Stream<List<VemResponse>> responsesForVem(String vemId) {
    return vemResponseCollection
        .where('vemId', isEqualTo: vemId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                VemResponse.fromEntity(VemResponseEntity.fromSnapshot(doc)))
            .toList());
  }

  @override
  Stream<List<VemResponse>> responsesForUser(String userId) {
    return vemResponseCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                VemResponse.fromEntity(VemResponseEntity.fromSnapshot(doc)))
            .toList());
  }

  @override
  Stream<Map<String, Stream<List<VemResponse>>>> groupedVemResponses() async* {
    // Build map
    final Map<String, Stream<List<VemResponse>>> vemResponses =
        Map<String, Stream<List<VemResponse>>>.identity();
    // Then iterate over it and yield
    // vemCollection.snapshots().forEach(
    //       (vemQuery) => vemQuery.docs.forEach(
    //         (vemDoc) {
    //           print('HELLOOOOOO');
    //           vemResponses['${vemDoc.reference.id}'] =
    //               await responsesForVem(vemDoc.reference.id);
    //         },
    //       ),
    //     );
    print('responses 3: $vemResponses');
    yield vemResponses;
  }

  @override
  Future<void> addResponseChange(ResponseChange change) {
    return responseChangeCollection.add(change.toEntity().toDocument());
  }

  @override
  Future<void> updateResponseChange(ResponseChange change) {
    return responseChangeCollection
        .doc(change.id)
        .update(change.toEntity().toDocument());
  }
}

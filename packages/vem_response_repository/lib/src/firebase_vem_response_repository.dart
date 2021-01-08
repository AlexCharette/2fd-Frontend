import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'entities/entities.dart';

class FirebaseVemResponseRepository implements VemResponseRepository {
  final vemCollection = FirebaseFirestore.instance.collection('vems');
  final vemResponseCollection =
      FirebaseFirestore.instance.collection('responses');

  @override
  Future<void> addVemResponse(VemResponse response) {
    return vemCollection.add(response.toEntity().toDocument());
  }

  @override
  Future<void> updateVemResponse(VemResponse response) {
    return vemCollection
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

  //   // Chart
  //   // vems
  //   // |-- doc XYZ
  //   //     |-- responses
  //   //         |-- doc ABC
  Stream<List<VemResponse>> responsesForVem(String vemId) {
    return vemCollection
        .doc(vemId)
        .collection('responses')
        .snapshots()
        .map((responseQuery) => responseQuery.docs
            .map(
              (responseDoc) => VemResponse.fromEntity(
                  VemResponseEntity.fromSnapshot(responseDoc)),
            )
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
}

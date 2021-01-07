import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

// TODO if response exists: update instead of add
//                          render based on current response
class VemResponder extends Dialog {
  final Vem vem;
  final VemResponse currentResponse;

  VemResponder({
    Key key,
    @required this.vem,
    this.currentResponse,
  }) : super(key: key);

  void _submitResponse(BuildContext context, String answer) {
    BlocProvider.of<VemResponsesBloc>(context).add(
      currentResponse != null
          ? UpdateVemResponse(
              vem.id,
              VemResponse(
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                answer,
              ),
            )
          : AddVemResponse(
              vem.id,
              VemResponse(
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                answer,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Center(
          key: Key('__vem_responder_${vem.id}'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: '${vem.id}__heroTag',
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Respond to ${vem.name}',
                  ),
                ),
              ),
              RaisedButton(
                onPressed:
                    (currentResponse != null && currentResponse.answer != 'yes')
                        ? () {
                            _submitResponse(context, 'yes');
                            //_hideWidget();
                            Navigator.pop(context);
                          }
                        : null,
                child: Text('Confirm my attendance'), // TODO
              ),
              RaisedButton(
                onPressed:
                    (currentResponse != null && currentResponse.answer != 'no')
                        ? () {
                            _submitResponse(context, 'no');
                          }
                        : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* TODO when pressed outside
              onPressed: () {
                BlocProvider.of<VemResponsesBloc>(context).add(
                  AddVemResponse(
                    vem.id,
                    VemResponse(
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                      'seen',
                    ),
                  ),
                );
                hideWidget();
              }
*/

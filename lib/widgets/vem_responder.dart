import 'package:bloc/bloc.dart';
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
class VemResponder extends StatefulWidget {
  final Vem vem;
  final VemResponse currentResponse;
  final GestureTapCallback onTap;

  VemResponder({
    Key key,
    @required this.onTap,
    @required this.vem,
    this.currentResponse,
  }) : super(key: key);

  @override
  _VemResponderState createState() => _VemResponderState();
}

class _VemResponderState extends State<VemResponder> {
  bool isVisible = true;

  void _hideWidget() {
    setState(() {
      isVisible = false;
    });
  }

  void _submitResponse(String answer) {
    BlocProvider.of<VemResponsesBloc>(context).add(
      widget.currentResponse != null
          ? UpdateVemResponse(
              widget.vem.id,
              VemResponse(
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                answer,
              ),
            )
          : AddVemResponse(
              widget.vem.id,
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
    return Visibility(
      maintainState: true,
      visible: isVisible,
      child: Center(
        key: Key('__vem_responder_${widget.vem.id}'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: '${widget.vem.id}__heroTag',
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Respond to ${widget.vem.name}',
                ),
              ),
            ),
            RaisedButton(
              onPressed: (widget.currentResponse != null &&
                      widget.currentResponse.answer != 'yes')
                  ? () {
                      _submitResponse('yes');
                      _hideWidget();
                    }
                  : null,
              child: Text('Confirm my attendance'), // TODO
            ),
            RaisedButton(
              onPressed: (widget.currentResponse != null &&
                      widget.currentResponse.answer != 'no')
                  ? () {
                      _submitResponse('no');
                      _hideWidget();
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/* TODO when pressed outside
              onPressed: () {
                BlocProvider.of<VemResponsesBloc>(context).add(
                  AddVemResponse(
                    widget.vem.id,
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

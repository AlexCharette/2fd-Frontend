import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemResponder extends StatefulWidget {
  final Vem vem;

  VemResponder({
    Key key,
    @required this.vem,
  }) : super(key: key);

  @override
  VemResponderState createState() => VemResponderState();
}

class VemResponderState extends State<VemResponder> {
  bool isVisible = true;

  void hideWidget() {
    setState(() {
      isVisible = false;
    });
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
              onPressed: () {
                BlocProvider.of<VemResponsesBloc>(context).add(
                  AddVemResponse(
                    widget.vem.id,
                    VemResponse(
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                      'yes',
                    ),
                  ),
                );
                hideWidget();
              },
              child: Text('Confirm my attendance'), // TODO
            ),
            RaisedButton(
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
              },
              child: Text('I\'m not ready to answer yet'), // TODO
            ),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<VemResponsesBloc>(context).add(
                  AddVemResponse(
                    widget.vem.id,
                    VemResponse(
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid ?? ''),
                      'no',
                    ),
                  ),
                );
                hideWidget();
              },
              child: Text('Confirm my absence'), // TODO
            ),
          ],
        ),
      ),
    );
  }
}

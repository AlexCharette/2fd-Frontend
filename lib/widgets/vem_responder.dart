import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VemResponder extends StatelessWidget {
  final String vemId;
  final String vemName;

  VemResponder({
    Key key,
    @required this.vemId,
    @required this.vemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key('__vem_responder_$vemId'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            tag: '${vemId}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Respond to $vemName',
              ),
            ),
          ),
          const RaisedButton(
            // onPressed: () {}  update / create vemResponse
            child: Text('Confirm my attendance'), // TODO
          ),
          const RaisedButton(
            // onPressed: () {}, update / create vemResponse
            child: Text('I\'m not ready to answer yet'), // TODO
          ),
          const RaisedButton(
            // onPressed: () {}, update / create vemResponse
            child: Text('Confirm my absence'),
          ),
        ],
      ),
    );
  }
}

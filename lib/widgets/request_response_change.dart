import 'package:flutter/material.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class RequestResponseChange extends Dialog {
  final VemResponse currentResponse;
  String _reason;

  RequestResponseChange({
    Key key,
    @required this.currentResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: '${currentResponse.id}__heroTag',
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'I want to change my response',
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Why are you requesting a change at this time?'),
                onChanged: (value) => _reason = value,
              ),
              RaisedButton(
                color:
                    AppColors.buttonGreen, // TODO if no reason, appear disabled

                onPressed: (_reason.isNotEmpty)
                    ? () {
                        // TODO Send new response to 2ic & ic
                        Navigator.pop(context);
                      }
                    : null,
                child: Text('Submit my request'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

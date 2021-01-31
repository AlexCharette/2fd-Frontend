import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/generated/l10n.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

// TODO render based on current response
class VemResponder extends Dialog {
  final String vemName;
  final String vemId;
  final VemResponse currentResponse;

  VemResponder({
    Key key,
    @required this.vemName,
    @required this.vemId,
    this.currentResponse,
  }) : super(key: key) {
    print('Current response: ${this.currentResponse}');
  }

  void _submitResponse(BuildContext context, String answer) {
    final userState = context.read<UsersBloc>().state;
    final currentUser = (userState as CurrentUserLoaded).currentUser;
    BlocProvider.of<VemResponsesBloc>(context).add(
      currentResponse != null
          ? UpdateVemResponse(currentResponse.copyWith(answer: answer))
          : AddVemResponse(
              VemResponse(
                currentUser.id,
                currentUser.initials,
                vemId,
                currentUser.detId,
                answer,
              ),
            ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SimpleDialog(
      children: <Widget>[
        Center(
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
                    style: TextStyle(color: theme.accentColor),
                  ),
                ),
              ),
              RaisedButton(
                color: AppColors.buttonGreen,
                onPressed:
                    (currentResponse == null || currentResponse.answer != 'yes')
                        ? () {
                            Navigator.pop(context, 'yes');
                            // _submitResponse(context, 'yes');
                          }
                        : null,
                child: Text(S.of(context).buttonAnswerYes),
              ),
              RaisedButton(
                color: AppColors.buttonRed,
                onPressed:
                    (currentResponse == null || currentResponse.answer != 'no')
                        ? () {
                            Navigator.pop(context, 'no');
                            // _submitResponse(context, 'no');
                          }
                        : null,
                child: Text(S.of(context).buttonAnswerNo),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

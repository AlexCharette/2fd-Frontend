import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/generated/l10n.dart';
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
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        _reason = '';
        if (state is CurrentUserLoading) {
          return CircularProgressIndicator();
        } else if (state is CurrentUserLoaded) {
          final detId = state.currentUser.detId;
          return SimpleDialog(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                      tag: '${currentResponse.id}__heroTag', // TODO fix
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          S.of(context).titleRequestResponseChange,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.of(context).inputHintReason),
                      onChanged: (value) => _reason = value,
                    ),
                    RaisedButton(
                      color: AppColors.buttonGreen,
                      onPressed: (_reason.isNotEmpty)
                          ? () {
                              BlocProvider.of<UserResponsesBloc>(context).add(
                                AddResponseChange(
                                  ResponseChange(
                                    detId,
                                    FirebaseAuth.instance.currentUser?.uid,
                                    currentResponse.id,
                                    currentResponse.answer == 'yes'
                                        ? 'no'
                                        : 'yes',
                                    _reason,
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(S.of(context).buttonSubmit),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regimental_app/blocs/blocs.dart';
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
                          hintText:
                              'Why are you requesting a change at this time?'),
                      onChanged: (value) => _reason = value,
                    ),
                    RaisedButton(
                      color: AppColors
                          .buttonGreen, // TODO if no reason, appear disabled

                      onPressed: (_reason.isNotEmpty)
                          ? () {
                              BlocProvider.of<VemResponsesBloc>(context).add(
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
                      child: Text('Submit my request'),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // final snackBar = SnackBar(
          //   content:
          //       Text('Sorry, we can\'t process your request at the moment'),
          // );
          // Scaffold.of(context).showSnackBar(snackBar);
          return Container();
        }
      },
    );
  }
}

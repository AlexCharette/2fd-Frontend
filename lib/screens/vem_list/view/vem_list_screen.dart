import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/vem_details/view/view.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:regimental_app/screens/screens.dart';
import 'package:vem_repository/vem_repository.dart' show Vem;
import 'package:vem_response_repository/vem_response_repository.dart'
    show VemResponse;

class VemList extends StatelessWidget {
  VemList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final vemsState = context.watch<VemsBloc>().state;
        final responsesState = context.watch<VemResponsesBloc>().state;
        if (vemsState is VemsLoading &&
            responsesState is UserResponsesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (vemsState is VemsLoaded &&
            responsesState is UserResponsesLoaded) {
          List<Vem> vems = vemsState.vems;
          List<VemResponse> vemResponses = responsesState.vemResponses;
          if (vems.length > 0) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).primaryColor,
              ),
              itemCount: vems.length,
              itemBuilder: (context, index) {
                Vem vem = vems[index];
                VemResponse response = vemResponses
                        .where((response) => response.vemId == vem.id)
                        .isNotEmpty
                    ? vemResponses
                        .where((response) => response.vemId == vem.id)
                        .first
                    : null;
                print('response for ${vem.name}: ${response?.id}');
                return VemItem(
                  vem: vem,
                  numParticipants: vem.numParticipants,
                  isAttending: (response != null && response.answer == 'yes')
                      ? true
                      : false,
                  onTap: () async {
                    // go to vem details screen
                    Navigator.pushNamed(
                      context,
                      VemDetailsScreen.routeName,
                      arguments: VemDetailsScreenArguments(vem.id),
                    );
                  },
                  onLongPress: () async {
                    // Load vem responses
                    // if it isn't full
                    if (vem.numParticipants < vem.maxParticipants) {
                      // If the lock date has not passed
                      if (Timestamp.now().compareTo(vem.lockDate) <= 0) {
                        // open vem response widget
                        String answer = await showDialog(
                          context: context,
                          builder: (context) => VemResponder(
                            vemId: vem.id,
                            vemName: vem.name,
                            currentResponse: response,
                          ),
                        );

                        if (response == null && answer == null) {
                          answer = 'seen';
                        }
                        if (response.answer != answer) {
                          BlocProvider.of<VemResponsesBloc>(context).add(
                            response != null
                                ? UpdateVemResponse(
                                    response.copyWith(answer: answer))
                                : AddVemResponse(
                                    VemResponse(
                                      FirebaseAuth.instance.currentUser?.uid,
                                      vem.id,
                                      answer,
                                    ),
                                  ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => RequestResponseChange(
                            currentResponse: response,
                          ),
                        );
                      }
                    } else {
                      // else popup saying it's full
                      final snackBar = SnackBar(
                        content: Text(
                            'Maximum attendance for this VEM has been reached.'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  },
                );
              },
            );
          } else if (vems.length == 0) {
            return Center(
              child: Container(
                child: Text(
                  'PAS DE VEMS DISPONIBLES',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else {
            assert(true,
                'This should NEVER EVER happen... How the fuck are we in the negatives');
            return _ErrorDialog();
          }
        } else {
          //TODO: when clicking on the vem this happens for a fraction of second because the state is changing (thats my guess) so we can't display an error
          //we need to figure something out
          return Container(
            child: Text(''),
          );
        }
      },
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error',
        style: TextStyle(color: Colors.blueAccent),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('There has been an error with the vem list.'),
            Text(
                'Please communicate this issue with one of the developers: Bdr Charette or Bdr Hoyos'),
            Text('We are sorry for the inconvenience')
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Retry vem list'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .pushAndRemoveUntil(HomeScreen.route(), (route) => false);
          },
        ),
      ],
    );
  }
}

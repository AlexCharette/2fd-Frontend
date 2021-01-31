import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/vem_details/view/view.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:regimental_app/screens/screens.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemList extends StatelessWidget {
  VemList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackbar = SnackBar(
      content: Text(
        'Maximum attendance for this VEM has been reached.',
      ),
    );
    return Builder(
      builder: (context) {
        final vemsState = context.watch<VemsBloc>().state;
        final userResponsesState = context.watch<UserResponsesBloc>().state;
        final userState = context.read<UsersBloc>().state;
        if (vemsState is VemsLoading &&
            userResponsesState is UserResponsesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (vemsState is VemsLoaded &&
            userResponsesState is UserResponsesLoaded &&
            userState is CurrentUserLoaded) {
          final vems = vemsState.vems;
          List<VemResponse> vemResponses = userResponsesState.responses;
          final currentUser = userState.currentUser;
          if (vems.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).primaryColor,
              ),
              itemCount: vems.length,
              itemBuilder: (context, index) {
                final vem = vems[index];
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
                    if (response == null) {
                      response = VemResponse(
                        currentUser.id,
                        currentUser.initials,
                        vem.id,
                        currentUser.detId,
                        'seen',
                      );
                      BlocProvider.of<UserResponsesBloc>(context).add(
                        AddUserResponse(response),
                      );
                    }
                    if (!(currentUser is NormalMember)) {
                      BlocProvider.of<VemResponsesBloc>(context).add(
                        LoadResponsesForVem(vem.id),
                      );
                    }
                    // go to vem details screen
                    Navigator.pushNamed(
                      context,
                      VemDetailsScreen.routeName,
                      arguments: VemDetailsScreenArguments(
                        vemId: vem.id,
                        currentResponseId:
                            (response.id != null) ? response.id : null,
                      ),
                    );
                  },
                  onLongPress: () async {
                    String newAnswer = '';
                    if (response == null) {
                      VemResponse tempResponse = VemResponse(
                        currentUser.id,
                        currentUser.initials,
                        vem.id,
                        currentUser.detId,
                        'seen',
                      );
                      BlocProvider.of<UserResponsesBloc>(context).add(
                        AddUserResponse(tempResponse),
                      );
                      // TODO retrieve response from firebase and store it in variable
                      var query = await FirebaseFirestore.instance
                          .collection('responses')
                          .where('vemId', isEqualTo: vem.id)
                          .where('userId', isEqualTo: currentUser.id)
                          .limit(1)
                          .get();
                      response = VemResponse.fromEntity(
                          VemResponseEntity.fromSnapshot(query.docs.first));
                      print('BESPOKE RESPONSE: $response');
                    }
                    switch (response.answer) {
                      case 'seen': // no answer
                        if (vem.isFull()) {
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          if (vem.isLocked()) {
                            showDialog(
                              context: context,
                              builder: (context) => RequestResponseChange(
                                currentResponse: response,
                              ),
                            );
                          } else {
                            newAnswer = await showDialog(
                              context: context,
                              builder: (context) => VemResponder(
                                vemId: vem.id,
                                vemName: vem.name,
                                currentResponse: response,
                              ),
                            );
                          }
                        }
                        break;
                      case 'yes':
                        if (vem.isLocked()) {
                          showDialog(
                            context: context,
                            builder: (context) => RequestResponseChange(
                              currentResponse: response,
                            ),
                          );
                        } else {
                          newAnswer = await showDialog(
                            context: context,
                            builder: (context) => VemResponder(
                              vemId: vem.id,
                              vemName: vem.name,
                              currentResponse: response,
                            ),
                          );
                        }
                        break;
                      case 'no':
                        if (vem.isFull()) {
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          if (vem.isLocked()) {
                            showDialog(
                              context: context,
                              builder: (context) => RequestResponseChange(
                                currentResponse: response,
                              ),
                            );
                          } else {
                            newAnswer = await showDialog(
                              context: context,
                              builder: (context) => VemResponder(
                                vemId: vem.id,
                                vemName: vem.name,
                                currentResponse: response,
                              ),
                            );
                          }
                        }
                        break;
                      default:
                        break;
                    }
                    // If the answer changed,
                    if (newAnswer != null && response.answer != newAnswer) {
                      BlocProvider.of<UserResponsesBloc>(context).add(
                        UpdateUserResponse(
                          response.copyWith(
                              answer: newAnswer), // TODO fix this error
                        ),
                      );
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
            assert(
              true,
              'This should NEVER EVER happen... How the fuck are we in the negatives',
            );
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemDetailsScreenArguments {
  final Vem vem;

  VemDetailsScreenArguments(this.vem);
}

class VemDetailsScreen extends StatefulWidget {
  static const routeName = Routes.vemDetails;

  @override
  _VemDetailsScreenState createState() => _VemDetailsScreenState();
}

class _VemDetailsScreenState extends State<VemDetailsScreen> {
  Future<bool> _onPop(BuildContext context) {
    BlocProvider.of<VemResponsesBloc>(context)
        .add(LoadResponsesForUser(FirebaseAuth.instance.currentUser?.uid));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final VemDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    BlocProvider.of<VemResponsesBloc>(context).add(
      LoadResponsesForVem(args.vem.id),
    );
    return WillPopScope(
      child: CustomScaffold(
        appBarTitle: args.vem.name,
        body: BlocBuilder<VemResponsesBloc, VemResponsesState>(
          builder: (context, state) {
            if (state is VemResponsesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VemResponsesLoaded) {
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          args.vem.name,
                          style: theme.textTheme.headline6,
                        ),
                        completionIcon(args.vem, state.vemResponses)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top:
                              BorderSide(width: 1.0, color: theme.primaryColor),
                          right:
                              BorderSide(width: 1.0, color: theme.primaryColor),
                          bottom:
                              BorderSide(width: 1.0, color: theme.primaryColor),
                          left:
                              BorderSide(width: 1.0, color: theme.primaryColor),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            DateDisplay(
                              icon: Icons.date_range_outlined,
                              date: args.vem.startDate,
                            ),
                            args.vem.endDate != null
                                ? DateDisplay(
                                    icon: Icons.date_range_outlined,
                                    date: args.vem.endDate,
                                  )
                                : null,
                            DateDisplay(
                                icon: Icons.lock_clock,
                                date: args.vem.lockDate),
                          ],
                        ),
                      ),
                    ),
                  ),
                  args.vem.description != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5, 10, 10),
                          child: Row(
                            children: [
                              Text(
                                args.vem.description,
                                softWrap: true,
                              ),
                            ],
                          ),
                        )
                      : null,
                  // TODO responses widget (only display if allowed)
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButtons: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'moreActionButton__heroTag',
              tooltip: 'More',
              child: Icon(Icons.list),
              onPressed: () {
                // TODO display buttons to go to answer details or participation list
              },
            ),
            FloatingActionButton(
                heroTag: 'editActionButton__heroTag',
                tooltip: 'Edit VEM',
                child: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddEditVemScreen.routeName,
                    arguments: AddEditVemScreenArguments(
                      args.vem,
                      (
                        name,
                        startDate,
                        endDate,
                        lockDate,
                        responseType,
                        description,
                        minParticipants,
                        maxParticipiants,
                      ) {
                        BlocProvider.of<VemsBloc>(context).add(
                          UpdateVem(args.vem.copyWith(
                            name: name,
                            startDate: startDate,
                            endDate: endDate,
                            lockDate: lockDate,
                            responseType: responseType,
                            description: description,
                            minParticipants: minParticipants,
                            maxParticipants: maxParticipiants,
                          )),
                        );
                      },
                      true,
                    ),
                  );
                }),
          ],
        ),
        displayBottomAppBar: false,
      ),
      onWillPop: () async => _onPop(context),
    );
  }

  Widget completionIcon(Vem vem, List<VemResponse> response) {
    Widget completionStatus;
    if (response == null || response.length < vem.minParticipants) {
      completionStatus = Row(
        children: [
          Text(
            "${response != null ? response.length : 0}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.red[900]),
          ),
          Icon(
            Icons.people,
            color: Colors.red[900],
          ),
        ],
      );
    } else if (response.length >= vem.minParticipants &&
        response.length < vem.maxParticipants) {
      completionStatus = Row(
        children: [
          Text(
            "${response.length}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.green[700]),
          ),
          Icon(
            Icons.check_circle_outline,
            color: Colors.white54,
            size: 35,
          ),
        ],
      );
    } else if (response.length == vem.minParticipants) {
      completionStatus = Icon(
        Icons.check_circle,
        color: AppColors.white,
        size: 35,
      );
    } else {
      return null;
    }
    return completionStatus;
  }
}

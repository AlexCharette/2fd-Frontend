import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/config.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemDetailsScreenArguments {
  final String vemId;
  final String currentResponseId;
  VemDetailsScreenArguments({this.vemId, this.currentResponseId});
}

class VemDetailsScreen extends StatefulWidget {
  static const routeName = Routes.vemDetails;

  @override
  _VemDetailsScreenState createState() => _VemDetailsScreenState();
}

class _VemDetailsScreenState extends State<VemDetailsScreen> {
  Vem _vem;
  VemResponse _response;

  Future<bool> _onPop(BuildContext context) async {
    BlocProvider.of<VemResponsesBloc>(context)
        .add(LoadResponsesForUser(FirebaseAuth.instance.currentUser.uid));
    Navigator.of(context).pop(true);
    return true;
  }

  void _submitResponse(BuildContext context, String answer) {
    BlocProvider.of<VemResponsesBloc>(context).add(
      _response != null
          ? UpdateVemResponse(_response.copyWith(answer: answer))
          : AddVemResponse(
              VemResponse(
                FirebaseAuth.instance.currentUser?.uid,
                _vem.id,
                answer,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final VemDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments as VemDetailsScreenArguments;
    // BlocProvider.of<VemResponsesBloc>(context).add(
    //   LoadResponsesForVem(args.vemId),
    // );
    // return Builder(
    //   builder: (context) {
    final vemsState = context.watch<VemsBloc>().state;
    final responsesState = context.watch<VemResponsesBloc>().state;
    final vem = (vemsState as VemsLoaded)
        .vems
        .firstWhere((vem) => vem.id == args.vemId, orElse: () => null);
    final response = (responsesState as UserResponsesLoaded)
        .vemResponses
        .firstWhere((response) => response.id == args.currentResponseId,
            orElse: () => null);
    setState(() {
      _vem = vem;
      _response = response;
    });
    return WillPopScope(
      onWillPop: () async => _onPop(context),
      child: CustomScaffold(
        appBarTitle: _vem.name,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _vem.name,
                    style: theme.textTheme.headline6,
                  ),
                  CompletionIcon(vem: _vem),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: theme.primaryColor),
                    right: BorderSide(width: 1.0, color: theme.primaryColor),
                    bottom: BorderSide(width: 1.0, color: theme.primaryColor),
                    left: BorderSide(width: 1.0, color: theme.primaryColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DateDisplay(
                        icon: Icons.date_range_outlined,
                        date: _vem.startDate,
                      ),
                      _vem.endDate != null
                          ? DateDisplay(
                              icon: Icons.date_range_outlined,
                              date: _vem.endDate,
                            )
                          : null,
                      DateDisplay(icon: Icons.lock_clock, date: _vem.lockDate),
                    ],
                  ),
                ),
              ),
            ),
            _vem.description != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5, 10, 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _vem.description,
                          softWrap: true,
                        ),
                      ],
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _vem.isFull()
                  ? Container()
                  : _vem.isLocked()
                      ? OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => RequestResponseChange(
                                currentResponse: _response,
                              ),
                            );
                          },
                          child: Text('I want to change my answer'),
                        )
                      : // request response
                      ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: AppColors.buttonGreen,
                              onPressed: (_response == null ||
                                      _response.answer != 'yes')
                                  ? () {
                                      _submitResponse(context, 'yes');
                                    }
                                  : null,
                              child: Text('I\'ll be there'),
                            ),
                            RaisedButton(
                              color: AppColors.buttonRed,
                              onPressed: (_response == null ||
                                      _response.answer != 'no')
                                  ? () {
                                      _submitResponse(context, 'no');
                                    }
                                  : null,
                              child: Text('I won\'t be there'),
                            ),
                          ],
                        ),
            ),
            // TODO responses widget (only display if allowed)
          ],
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
                      _vem,
                      (
                        name,
                        startDate,
                        endDate,
                        lockDate,
                        responseType,
                        description,
                        minParticipants,
                        maxParticipants,
                      ) {
                        print(
                            '$name, $startDate, $endDate, $lockDate, $responseType, $description, $minParticipants, $maxParticipants');
                        BlocProvider.of<VemsBloc>(context).add(
                          UpdateVem(vem.copyWith(
                            name: name,
                            startDate: startDate,
                            endDate: endDate,
                            lockDate: lockDate,
                            responseType: responseType,
                            description: description,
                            minParticipants: minParticipants,
                            maxParticipants: maxParticipants,
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
    );
  }
}

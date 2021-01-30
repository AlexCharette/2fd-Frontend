import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/config.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:user_repository/user_repository.dart' show NormalMember;
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemDetailsScreenArguments {
  final String vemId;
  final String currentResponseId;
  VemDetailsScreenArguments({this.vemId, this.currentResponseId});
}

class VemDetailsScreen extends StatefulWidget {
  static const routeName = Routes.vemDetails;

  VemDetailsScreen({Key key}) : super(key: key);

  @override
  _VemDetailsScreenState createState() => _VemDetailsScreenState();
}

class _VemDetailsScreenState extends State<VemDetailsScreen> {
  Vem _vem;
  VemResponse _response;
  String _answer;

  Future<bool> _onPop(BuildContext context) async {
    BlocProvider.of<UserResponsesBloc>(context)
        .add(LoadResponsesForUser(FirebaseAuth.instance.currentUser.uid));
    Navigator.of(context).pop(true);
    return true;
  }

  void _submitResponse(BuildContext context, String answer) {
    setState(() => _answer = answer);
    final userState = context.read<UsersBloc>().state;
    final currentUser = (userState as CurrentUserLoaded).currentUser;
    BlocProvider.of<VemResponsesBloc>(context).add(
      _response != null
          ? UpdateVemResponse(_response.copyWith(answer: answer))
          : AddVemResponse(
              VemResponse(
                currentUser.id,
                currentUser.initials,
                _vem.id,
                currentUser.detId,
                answer,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Builder(builder: (context) {
      final vemsState = context.watch<VemsBloc>().state;
      final userResponsesState = context.watch<UserResponsesBloc>().state;
      final usersState = context.read<UsersBloc>().state;

      final VemDetailsScreenArguments args = ModalRoute.of(context)
          .settings
          .arguments as VemDetailsScreenArguments;

      final currentUser = (usersState as CurrentUserLoaded).currentUser;
      final vem = (vemsState as VemsLoaded)
          .vems
          .firstWhere((vem) => vem.id == args.vemId, orElse: () => null);
      final response = (userResponsesState as UserResponsesLoaded)
          .responses
          .firstWhere((response) => response.id == args.currentResponseId,
              orElse: () => null);
      if (response != null) {
        _answer = response.answer;
        _response = response;
      } else {
        _response = null;
        _answer = 'seen';
      }
      _vem = vem;
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
                        DateDisplay(
                            icon: Icons.lock_clock, date: _vem.lockDate),
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
                child: _responseButtons(),
              ),
              !(currentUser is NormalMember)
                  ? VemResponses(vemId: vem.id)
                  : Container(),
            ],
          ),
          floatingActionButtons: !(currentUser is NormalMember)
              ? Row(
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
                                BlocProvider.of<VemsBloc>(context).add(
                                  UpdateVem(_vem.copyWith(
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
                )
              : null,
          displayBottomAppBar: false,
        ),
      );
    });
  }

  Widget _responseButtons() {
    final snackbar = SnackBar(
      content: Text(
        'Maximum attendance for this VEM has been reached.',
      ),
    );
    switch (_response.answer) {
      case 'seen': // no answer
        if (_vem.isFull()) {
          Scaffold.of(context).showSnackBar(snackbar);
          return Text('This VEM is full');
        } else {
          if (_vem.isLocked()) {
            // TODO return request change buttons
            return _requestChangeButton();
          } else {
            // TODO return choice buttons
            return _answerButtons();
          }
        }
        break;
      case 'yes':
        if (_vem.isLocked()) {
          // TODO return request change button
          return _requestChangeButton();
        } else {
          // TODO return choice buttons
          return _answerButtons();
        }
        break;
      case 'no':
        if (_vem.isFull()) {
          Scaffold.of(context).showSnackBar(snackbar);
          return Text('This VEM is full');
        } else {
          if (_vem.isLocked()) {
            // TODO return request change button
            return _requestChangeButton();
          } else {
            // TODO return choice buttons
            return _answerButtons();
          }
        }
        break;
      default:
        return Text('An error occured');
        break;
    }
  }

  Widget _answerButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: AppColors.buttonGreen,
          onPressed: (_response == null || _answer != 'yes')
              ? () => _submitResponse(context, 'yes')
              : null,
          child: Text('I\'ll be there'),
        ),
        RaisedButton(
          color: AppColors.buttonRed,
          onPressed: (_response == null || _answer != 'no')
              ? () => _submitResponse(context, 'no')
              : null,
          child: Text('I won\'t be there'),
        ),
      ],
    );
  }

  Widget _requestChangeButton() {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => RequestResponseChange(
            currentResponse: _response,
          ),
        );
      },
      child: Text('I want to change my answer'),
    );
  }
}

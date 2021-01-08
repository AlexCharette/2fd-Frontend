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
  final List<VemResponse> response;

  VemDetailsScreenArguments({this.vem, this.response});
}

class VemDetailsScreen extends StatefulWidget {
  static const routeName = Routes.vemDetails;
  // final Vem vem;

  // VemDetailsScreen(
  //   Key key,
  //   this.vem,
  // ) : super(key: key);

  @override
  _VemDetailsScreenState createState() => _VemDetailsScreenState();
}

class _VemDetailsScreenState extends State<VemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final VemDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return CustomScaffold(
      appBarTitle: args.vem.name,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.vem.name,
                  style: theme.textTheme.headline6,
                ),
                completionIcon()
                // Icon(
                //   Icons.check_circle_outline,
                //   size: 35,
                //   color: Colors.white30,
                // ),
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
                      date: Vem.timestampToYearMonthDayTime(args.vem.startDate),
                    ),
                    args.vem.endDate != null
                        ? DateDisplay(
                            icon: Icons.date_range_outlined,
                            date: Vem.timestampToYearMonthDayTime(
                                args.vem.endDate),
                          )
                        : null,
                    DateDisplay(
                      icon: Icons.lock_clock,
                      date: Vem.timestampToYearMonthDayTime(args.vem.lockDate),
                    ),
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
      ),
      floatingActionButtons: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Widget completionIcon(){
    Widget completionStatus;
    if (widget.response == null || widget.response.length < widget.vem.minParticipants){
      completionStatus = Row(
        children: [
          Text("${widget.response != null ? widget.response.length : 0}/${widget.vem.maxParticipants}", style: TextStyle(color: Colors.red),),
          Icon(Icons.people, color: Colors.red,),
        ],
      );
    }
    else if (widget.response.length >= widget.vem.minParticipants && widget.response.length < widget.vem.maxParticipants){
      completionStatus = Row(
        children: [
          Text("${widget.response.length}/${widget.vem.maxParticipants}", style: TextStyle(color: Colors.green),),
          Icon(Icons.check_circle_outline, color: Colors.white54, size: 35,),
        ],
      );
    }
    else if(widget.response.length == widget.vem.minParticipants){
      completionStatus = Icon(Icons.check_circle, color: AppColors.white, size: 35,);
    }
    else{
      return null;
    }
    return completionStatus;
  }
}

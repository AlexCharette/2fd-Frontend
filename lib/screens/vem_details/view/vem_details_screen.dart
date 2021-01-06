import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:vem_repository/vem_repository.dart';

class VemDetailsScreen extends StatefulWidget {
  final Vem vem;

  VemDetailsScreen(
    Key key,
    this.vem,
  ) : super(key: key);

  @override
  _VemDetailsScreenState createState() => _VemDetailsScreenState();
}

class _VemDetailsScreenState extends State<VemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomScaffold(
      appBarTitle: widget.vem.name,
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
                Icon(
                  Icons.check_circle_outline,
                  size: 35,
                  color: Colors.white30,
                ),
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
                      date:
                          Vem.timestampToYearMonthDayTime(widget.vem.startDate),
                    ),
                    widget.vem.endDate != null
                        ? DateDisplay(
                            icon: Icons.date_range_outlined,
                            date: Vem.timestampToYearMonthDayTime(
                                widget.vem.endDate),
                          )
                        : null,
                    DateDisplay(
                      icon: Icons.lock_clock,
                      date:
                          Vem.timestampToYearMonthDayTime(widget.vem.lockDate),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.vem.description != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5, 10, 10),
                  child: Row(
                    children: [
                      Text(
                        widget.vem.description,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditVemScreen(
                        onSave: (
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
                            UpdateVem(widget.vem.copyWith(
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
                        isEditing: true,
                        vem: widget.vem,
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}

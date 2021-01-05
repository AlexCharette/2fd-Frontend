import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.vem.name),
                // TODO change based on attendance, only display if allowed
                Icon(Icons.check_circle_outline_sharp),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: theme.primaryColor),
                  right: BorderSide(width: 1.0, color: theme.primaryColor),
                  bottom: BorderSide(width: 1.0, color: theme.primaryColor),
                  left: BorderSide(width: 1.0, color: theme.primaryColor),
                ),
              ),
              child: Row(), // TODO date displays
            ),
            Text(widget
                .vem.description), // TODO don't show if there isn't description
            // TODO responses widget (only display if allowed)
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'backActionButton__heroTag',
            tooltip: 'Back',
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FloatingActionButton(
            heroTag: 'moreActionButton__heroTag',
            tooltip: 'More',
            child: Icon(Icons.list),
            onPressed: () {
              // TODO display buttons to go to answer details or participation list
            },
          ),
          // TODO only display if editing possible
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
                        AddVem(Vem(
                          name,
                          responseType,
                          description: description,
                          startDate: startDate,
                          endDate: endDate,
                          lockDate: lockDate,
                          minParticipants: minParticipants,
                          maxParticipants: maxParticipiants,
                        )),
                      );
                    },
                    isEditing: false,
                    vem: widget.vem,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

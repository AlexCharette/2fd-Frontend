import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vem_repository/vem_repository.dart';

typedef OnSave = Function();

class AddEditVemScreen extends StatefulWidget {
  Vem vem;
  OnSave onSave;
  bool isEditing;

  AddEditVemScreen({
    Key key,
    this.vem,
    @required this.onSave,
    @required this.isEditing,
  }) : super(key: key);

  @override
  _AddEditVemScreenState createState() => _AddEditVemScreenState();
}

class _AddEditVemScreenState extends State<AddEditVemScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  Timestamp _startDate;
  Timestamp _endDate;
  Timestamp _lockDate;
  String _responseType;
  String _description;
  int _minParticipants;
  int _maxParticipants;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: isEditing ? widget.vem.name : '',
                      autofocus: !isEditing,
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'The VEM needs a name'
                            : null;
                      },
                      onSaved: (value) => _name = value,
                    ),
                    Row(
                      children: <
                          Widget>[], // TODO add icons that call showDatePicker
                    ),
                    Row(
                      children: <Widget>[
                        // TODO
                        // Icon(),
                        TextFormField(
                          initialValue: isEditing
                              ? widget.vem.minParticipants.toString()
                              : '1',
                          decoration: new InputDecoration(
                              labelText: 'Min participants'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (val) {
                            return _minParticipants > _maxParticipants
                                ? 'The maximum needs to be higher than the minimum.'
                                : null;
                          },
                        ),
                        TextFormField(
                          initialValue: isEditing
                              ? widget.vem.maxParticipants.toString()
                              : '0',
                          decoration: new InputDecoration(
                              labelText: 'Max participants'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (val) {
                            return _minParticipants > _maxParticipants
                                ? 'The maximum needs to be higher than the minimum.'
                                : null;
                          },
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}

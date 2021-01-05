import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vem_repository/vem_repository.dart';

typedef OnSave = Function(
  String name,
  Timestamp startDate,
  Timestamp endDate,
  Timestamp lockDate,
  String responseType,
  String description,
  int minParticipants,
  int maxParticipiants,
);

enum ResponseTypes {
  Battery,
  Other,
}

class AddEditVemScreen extends StatefulWidget {
  final Vem vem;
  final OnSave onSave;
  final bool isEditing;

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
                  return val.trim().isEmpty ? 'The VEM needs a name' : null;
                },
                onSaved: (value) => _name = value,
              ),
              Row(
                children: <Widget>[], // TODO add icons that call showDatePicker
              ),
              Row(
                children: <Widget>[
                  // TODO
                  // Icon(),
                  TextFormField(
                    initialValue:
                        isEditing ? widget.vem.minParticipants.toString() : '1',
                    decoration:
                        new InputDecoration(labelText: 'Min participants'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val) {
                      return _minParticipants > _maxParticipants
                          ? 'The maximum needs to be higher than the minimum.'
                          : null;
                    },
                    onSaved: (value) => _minParticipants = int.tryParse(value),
                  ),
                  TextFormField(
                    initialValue:
                        isEditing ? widget.vem.maxParticipants.toString() : '0',
                    decoration:
                        new InputDecoration(labelText: 'Max participants'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val) {
                      return _minParticipants > _maxParticipants
                          ? 'The maximum needs to be higher than the minimum.'
                          : null;
                    },
                    onSaved: (value) => _maxParticipants = int.tryParse(value),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  ListTile(
                    title: Text(ResponseTypes.Battery.toString()),
                    leading: Radio<String>(
                      value: ResponseTypes.Battery.toString(),
                      groupValue: _responseType,
                      onChanged: (String type) {
                        _responseType = type.toString();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ResponseTypes.Other.toString()),
                    leading: Radio<String>(
                      value: ResponseTypes.Other.toString(),
                      groupValue: _responseType,
                      onChanged: (String type) =>
                          _responseType = type.toString(),
                    ),
                  ),
                ],
              ),
              TextFormField(
                initialValue: isEditing
                    ? widget.vem.description
                    : 'Describe the what the VEM entails and requires.',
                decoration: new InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // TODO add confirmation widget
          FloatingActionButton(
            tooltip: 'Erase changes',
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // TODO add confirmation widget
          FloatingActionButton(
            tooltip: isEditing ? 'Save changes' : 'Publish VEM',
            child: Icon(isEditing ? Icons.check : Icons.add),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.onSave(
                  _name,
                  _startDate,
                  _endDate,
                  _lockDate,
                  _responseType,
                  _description,
                  _minParticipants,
                  _maxParticipants,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/widgets/widgets.dart';
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

class AddEditVemScreenArguments {
  final Vem vem;
  final OnSave onSave;
  final bool isEditing;

  AddEditVemScreenArguments(this.vem, this.onSave, this.isEditing);
}

class AddEditVemScreen extends StatefulWidget {
  static const routeName = Routes.addEditVem;

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
  GlobalKey<DateDisplayState> _startDateDisplayKey = GlobalKey();
  GlobalKey<DateDisplayState> _endDateDisplayKey = GlobalKey();
  GlobalKey<DateDisplayState> _lockDateDisplayKey = GlobalKey();

  Timestamp get startDate => _startDate;
  Timestamp get endDate => _endDate;
  Timestamp get lockDate => _lockDate;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final AddEditVemScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    bool isEditing = args.isEditing;
    _startDate = isEditing ? args.vem.startDate : Vem.getDefaultStartDate();
    _endDate = isEditing ? args.vem.endDate : Vem.getDefaultEndDate();
    _lockDate = isEditing ? args.vem.lockDate : Vem.getDefaultLockDate();
    _responseType = isEditing ? args.vem.responseType : 'battery';
    _minParticipants = isEditing ? args.vem.minParticipants : 1;
    _maxParticipants = isEditing ? args.vem.maxParticipants : null;

    return CustomScaffold(
      appBarTitle: isEditing ? args.vem.name : 'New VEM',
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: isEditing ? args.vem.name : '',
                    autofocus: !isEditing,
                    style:
                        theme.textTheme.headline6.copyWith(color: Colors.grey),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: EdgeInsets.all(3),
                        filled: true,
                        fillColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (val) {
                      return val.trim().isEmpty ? 'The VEM needs a name' : null;
                    },
                    onSaved: (val) => setState(() => _name = val),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.primaryColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DateTimeField(
                        decoration: InputDecoration(
                            labelText: 'Start',
                            icon: Icon(Icons.calendar_today),
                            fillColor: theme.primaryColor),
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _startDate.toDate()
                            : Vem.getDefaultStartDate(),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: isEditing
                                  ? _startDate.toDate()
                                  : DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                isEditing
                                    ? _startDate.toDate()
                                    : DateTime.now(),
                              ),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return DateTimeField.combine(_startDate.toDate(),
                                TimeOfDay.fromDateTime(_startDate.toDate()));
                          }
                        },
                        onSaved: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _startDate = date);
                        },
                      ),
                      DateTimeField(
                        decoration: InputDecoration(
                            labelText: 'End',
                            icon: Icon(Icons.calendar_today),
                            fillColor: theme.primaryColor),
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _endDate.toDate()
                            : Vem.getDefaultEndDate(),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: isEditing
                                  ? _endDate.toDate()
                                  : DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                isEditing ? _endDate.toDate() : DateTime.now(),
                              ),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return DateTimeField.combine(_endDate.toDate(),
                                TimeOfDay.fromDateTime(_endDate.toDate()));
                          }
                        },
                        onSaved: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _endDate = date);
                        },
                      ),
                      DateTimeField(
                        decoration: InputDecoration(
                            labelText: 'Lock',
                            icon: Icon(Icons.lock_clock),
                            fillColor: theme.primaryColor),
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _lockDate.toDate()
                            : Vem.getDefaultLockDate(),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: isEditing
                                  ? _lockDate.toDate()
                                  : DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                isEditing ? _lockDate.toDate() : DateTime.now(),
                              ),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return DateTimeField.combine(_lockDate.toDate(),
                                TimeOfDay.fromDateTime(_lockDate.toDate()));
                          }
                        },
                        onSaved: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _lockDate = date);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: theme.primaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue: isEditing
                              ? args.vem.minParticipants.toString()
                              : '1',
                          decoration: new InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              labelText: 'Min participants',
                              prefixIcon: Icon(
                                Icons.people,
                                color: theme.primaryColor,
                              )),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _minParticipants = temp;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Il doit avoir un minimum';
                            } else
                              return null;
                            // return int.tryParse(val) > _maxParticipants
                            //     ? 'The maximum needs to be higher than the minimum.'
                            //     : null;
                          },
                          onSaved: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _minParticipants = temp;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue: isEditing
                              ? args.vem.maxParticipants.toString()
                              : '0',
                          decoration: new InputDecoration(
                            labelText: 'Max participants',
                            prefixIcon:
                                Icon(Icons.people, color: theme.primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _maxParticipants = temp;
                            });
                          },
                          validator: (val) {
                            try {
                              return _minParticipants > _maxParticipants
                                  ? 'Minimum plus grand que max'
                                  : null;
                            } catch (e) {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _maxParticipants = temp;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  //decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RadioWithLabel<String>(
                          title: 'Battery',
                          value: 'battery',
                          groupValue: _responseType,
                          onChanged: (String type) {
                            print('changed response type');
                            setState(() {
                              _responseType = type;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RadioWithLabel<String>(
                          title: 'Other',
                          value: 'other',
                          groupValue: _responseType,
                          onChanged: (String type) {
                            print('changed response type');
                            setState(() {
                              _responseType = type;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                style:
                    theme.textTheme.bodyText1.copyWith(color: Colors.grey[600]),
                initialValue: isEditing
                    ? args.vem.description
                    : 'Describe what the VEM entails and requires.',
                decoration: new InputDecoration(
                  labelStyle: theme.textTheme.bodyText1,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: theme.primaryColor,
                ),
                onSaved: (value) => setState(() {
                  _description = value;
                }),
                maxLines: null,
                minLines: 7,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtons: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // TODO add confirmation args
          FloatingActionButton(
            heroTag: 'btnCancel',
            tooltip: 'Cancel changes',
            backgroundColor: Colors.red,
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // TODO add confirmation args
          FloatingActionButton(
            heroTag: 'btnConfirmChanges',
            tooltip: isEditing ? 'Save changes' : 'Publish VEM',
            backgroundColor: Colors.green[700],
            child: Icon(isEditing ? Icons.check : Icons.add),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                args.onSave(
                  this._name,
                  this._startDate,
                  this._endDate,
                  this._lockDate,
                  this._responseType,
                  this._description,
                  this._minParticipants,
                  this._maxParticipants,
                );
                BlocProvider.of<VemsBloc>(context).add(LoadVems());
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      displayBottomAppBar: false,
    );
  }
}

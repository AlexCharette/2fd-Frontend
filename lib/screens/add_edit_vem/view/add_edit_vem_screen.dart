import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/generated/l10n.dart';
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
  static final GlobalKey<FormBuilderState> _formKey =
      GlobalKey<FormBuilderState>();
  String _name;
  Timestamp _startDate;
  Timestamp _endDate;
  Timestamp _lockDate;
  String _responseType;
  String _description;
  int _minParticipants;
  int _maxParticipants;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final AddEditVemScreenArguments args =
        ModalRoute.of(context).settings.arguments as AddEditVemScreenArguments;

    bool isEditing = args.isEditing;
    _startDate = isEditing ? args.vem.startDate : Vem.getDefaultStartDate();
    _endDate = isEditing ? args.vem.endDate : Vem.getDefaultEndDate();
    _lockDate = isEditing ? args.vem.lockDate : Vem.getDefaultLockDate();
    _responseType = isEditing ? args.vem.responseType : 'battery';
    _minParticipants = isEditing ? args.vem.minParticipants : 1;
    _maxParticipants = isEditing ? args.vem.maxParticipants : null;

    return CustomScaffold(
      appBarTitle: isEditing ? args.vem.name : S.of(context).titleNewVem,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: FormBuilder(
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
                      return val.trim().isEmpty
                          ? S.of(context).inputValidatorVemName
                          : null;
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
                      FormBuilderDateTimePicker(
                        name: 'start_date',
                        decoration: InputDecoration(
                            labelText: S.of(context).inputLabelVemStartDate,
                            icon: Icon(Icons.calendar_today),
                            fillColor: theme.primaryColor),
                        inputType: InputType.both,
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _startDate.toDate()
                            : Vem.getDefaultStartDate().toDate(),
                        initialDate:
                            isEditing ? _startDate.toDate() : DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        initialTime: TimeOfDay.fromDateTime(
                          isEditing ? _startDate.toDate() : DateTime.now(),
                        ),
                        onChanged: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _startDate = date);
                        },
                        onSaved: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _startDate = date);
                        },
                      ),
                      FormBuilderDateTimePicker(
                        name: 'end_date',
                        decoration: InputDecoration(
                            labelText: S.of(context).inputLabelVemEndDate,
                            icon: Icon(Icons.calendar_today),
                            fillColor: theme.primaryColor),
                        inputType: InputType.both,
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _endDate.toDate()
                            : Vem.getDefaultEndDate().toDate(),
                        initialDate:
                            isEditing ? _endDate.toDate() : DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        initialTime: TimeOfDay.fromDateTime(
                          isEditing ? _endDate.toDate() : DateTime.now(),
                        ),
                        onChanged: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _endDate = date);
                        },
                        onSaved: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _endDate = date);
                        },
                      ),
                      FormBuilderDateTimePicker(
                        name: 'lock_date',
                        decoration: InputDecoration(
                            labelText: S.of(context).inputLabelVemLockDate,
                            icon: Icon(Icons.lock_clock),
                            fillColor: theme.primaryColor),
                        inputType: InputType.both,
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        initialValue: isEditing
                            ? _lockDate.toDate()
                            : Vem.getDefaultLockDate().toDate(),
                        initialDate:
                            isEditing ? _lockDate.toDate() : DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        initialTime: TimeOfDay.fromDateTime(
                          isEditing ? _lockDate.toDate() : DateTime.now(),
                        ),
                        onChanged: (val) {
                          final date = Timestamp.fromDate(val);
                          setState(() => _lockDate = date);
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
                        child: FormBuilderTextField(
                          name: 'minParticipants',
                          decoration: InputDecoration(
                            labelText:
                                S.of(context).inputLabelVemMinParticipants,
                            prefixIcon:
                                Icon(Icons.people, color: theme.primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: isEditing
                              ? args.vem.minParticipants.toString()
                              : '0', // TODO zero should mean no minimum required
                          onChanged: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _minParticipants = temp;
                            });
                          },
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 100),
                            (val) {
                              try {
                                return _minParticipants > _maxParticipants
                                    ? S.of(context).inputValidatorParticipants
                                    : null;
                              } catch (e) {
                                return null;
                              }
                            },
                          ]),
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
                        child: FormBuilderTextField(
                          name: 'maxParticipants',
                          decoration: InputDecoration(
                            labelText:
                                S.of(context).inputLabelVemMaxParticipants,
                            prefixIcon:
                                Icon(Icons.people, color: theme.primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: isEditing
                              ? args.vem.maxParticipants.toString()
                              : '0', // TODO zero should mean no minimum required
                          onChanged: (val) {
                            int temp = int.tryParse(val);
                            setState(() {
                              _maxParticipants = temp;
                            });
                          },
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 100),
                            (val) {
                              try {
                                return _minParticipants > _maxParticipants
                                    ? S.of(context).inputValidatorParticipants
                                    : null;
                              } catch (e) {
                                return null;
                              }
                            },
                          ]),
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
                child: FormBuilderRadioGroup(
                  name: 'response_type',
                  decoration: InputDecoration(
                      labelText: S.of(context).inputLabelVemResponseType),
                  initialValue: isEditing
                      ? _responseType
                      : ResponseTypes.Battery.toString().split('.').last,
                  onChanged: (dynamic val) {
                    setState(() => _responseType = val);
                  },
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(context)],
                  ),
                  options: ResponseTypes.values
                      .map((value) =>
                          value.toString().split('.').last.toLowerCase())
                      .map((value) => FormBuilderFieldOption(
                            value: value,
                            child: Text('$value'),
                          ))
                      .toList(growable: false),
                  onSaved: (dynamic val) {
                    setState(() => _responseType = val);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'description',
                keyboardType: TextInputType.multiline,
                style:
                    theme.textTheme.bodyText1.copyWith(color: Colors.grey[600]),
                initialValue: isEditing ? args.vem.description : '',
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
            tooltip: S.of(context).buttonCancelChanges,
            backgroundColor: Colors.red,
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // TODO add confirmation args
          FloatingActionButton(
            heroTag: 'btnConfirmChanges',
            tooltip: isEditing
                ? S.of(context).buttonSaveChanges
                : S.of(context).buttonPublishVem,
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

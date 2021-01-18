import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    onSaved: (value) => _name = value,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DateDisplay(
                        key: _startDateDisplayKey,
                        icon: Icons.date_range_outlined,
                        date: startDate,
                        onTap: () async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: isEditing
                                ? args.vem.startDate.toDate()
                                : Vem.getDefaultStartDate().toDate(),
                            firstDate: isEditing
                                ? args.vem.startDate.toDate()
                                : Vem.getDefaultStartDate().toDate(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );

                          if (date == null) {
                            Timestamp tempDate = isEditing
                                ? args.vem.startDate
                                : Vem.getDefaultStartDate();
                            return setState(() => _startDate = tempDate);
                          }

                          TimeOfDay time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 8, minute: 0));
                          Timestamp fullDate = Timestamp.fromDate(DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          ));
                          print('NEW START DATE AND TIME: $fullDate -- $time');
                          setState(() => _startDate = fullDate);
                          print('IN STATE: $_startDate');
                          _startDateDisplayKey.currentState
                              .updateDate(_startDate);
                        },
                      ),
                      args.vem != null && args.vem.endDate != null
                          ? DateDisplay(
                              key: _endDateDisplayKey,
                              icon: Icons.date_range_outlined,
                              date: endDate,
                              onTap: () async {
                                DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: isEditing
                                      ? args.vem.endDate.toDate()
                                      : Vem.getDefaultEndDate().toDate(),
                                  firstDate: isEditing
                                      ? args.vem.endDate.toDate()
                                      : Vem.getDefaultEndDate().toDate(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)),
                                );

                                if (date == null) {
                                  Timestamp tempDate = isEditing
                                      ? args.vem.endDate
                                      : Vem.getDefaultEndDate();
                                  return setState(() => _endDate = tempDate);
                                }

                                TimeOfDay time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: 17, minute: 0));
                                Timestamp fullDate =
                                    Timestamp.fromDate(DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  time.hour,
                                  time.minute,
                                ));
                                print('NEW END DATE: $fullDate');
                                setState(() => _endDate = fullDate);
                                _endDateDisplayKey.currentState
                                    .updateDate(_endDate);
                              },
                            )
                          : null,
                      DateDisplay(
                        key: _lockDateDisplayKey,
                        icon: Icons.lock_clock,
                        date: lockDate,
                        onTap: () async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: isEditing
                                ? args.vem.lockDate.toDate()
                                : Vem.getDefaultLockDate().toDate(),
                            firstDate: isEditing
                                ? args.vem.lockDate.toDate()
                                : Vem.getDefaultLockDate().toDate(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );

                          if (date == null) {
                            Timestamp tempDate = isEditing
                                ? args.vem.lockDate
                                : Vem.getDefaultLockDate();
                            return setState(() => _lockDate = tempDate);
                          }

                          TimeOfDay time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 23, minute: 59));
                          Timestamp fullDate = Timestamp.fromDate(DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          ));

                          setState(() => _lockDate = fullDate);
                          _lockDateDisplayKey.currentState
                              .updateDate(_lockDate);
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
                          onChanged: (val) => setState(() {
                            _minParticipants = int.tryParse(val);
                          }),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Il doit avoir un minimum';
                            } else
                              return null;
                            // return int.tryParse(val) > _maxParticipants
                            //     ? 'The maximum needs to be higher than the minimum.'
                            //     : null;
                          },
                          onSaved: (val) => setState(() {
                            _minParticipants = int.tryParse(val);
                          }),
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
                          onChanged: (val) => setState(() {
                            _maxParticipants = int.tryParse(val);
                          }),
                          validator: (val) {
                            try {
                              return _minParticipants > _maxParticipants
                                  ? 'Minimum plus grand que max'
                                  : null;
                            } catch (e) {
                              return null;
                            }
                          },
                          onSaved: (val) => setState(() {
                            _maxParticipants = int.tryParse(val);
                          }),
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
      displayBottomAppBar: false,
    );
  }
}

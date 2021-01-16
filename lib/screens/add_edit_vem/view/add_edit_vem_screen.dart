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
  // final Vem vem;
  // final OnSave onSave;
  // final bool isEditing;

  // AddEditVemScreen({
  //   Key key,
  //   this.vem,
  //   @required this.onSave,
  //   @required this.isEditing,
  // }) : super(key: key);

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
  // int _minParticipants;
  // int _maxParticipants;
  // bool get isEditing => args.isEditing;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final AddEditVemScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    bool isEditing = args.isEditing;
    int _minParticipants = isEditing ? args.vem.minParticipants : 1;
    int _maxParticipants = isEditing ? args.vem.maxParticipants : null;
    return CustomScaffold(
      appBarTitle: isEditing ? args.vem.name : 'New VEM',
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*3/4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: TextFormField(
                    initialValue: isEditing ? args.vem.name : '',
                    autofocus: !isEditing,
                    style: theme.textTheme.headline6.copyWith(color: Colors.grey),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      contentPadding: EdgeInsets.all(3),
                      filled: true,
                      fillColor: Colors.white,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                          color: Colors.red
                        )
                      )
                    ),
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
                        icon: Icons.date_range_outlined,
                        date: Vem.timestampToYearMonthDayTime(args.vem.startDate),
                        onTap: () async => _startDate = Timestamp.fromDate(
                          await showDatePicker(
                              context: context,
                              initialDate: isEditing
                                  ? args.vem.startDate.toDate()
                                  : Vem.getDefaultStartDate().toDate(),
                              firstDate: Vem.getDefaultStartDate().toDate(),
                              lastDate: DateTime.now().add(Duration(days: 365))),
                        ),
                      ),
                      args.vem != null && args.vem.endDate != null
                          ? DateDisplay(
                              icon: Icons.date_range_outlined,
                              date:
                                  Vem.timestampToYearMonthDayTime(args.vem.endDate),
                              onTap: () async => _endDate = Timestamp.fromDate(
                                await showDatePicker(
                                    context: context,
                                    initialDate: isEditing
                                        ? args.vem.endDate.toDate()
                                        : Vem.getDefaultEndDate().toDate(),
                                    firstDate: Vem.getDefaultStartDate().toDate(),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365))),
                              ),
                            )
                          : null,
                      DateDisplay(
                        icon: Icons.lock_clock,
                        date: Vem.timestampToYearMonthDayTime(args.vem.lockDate),
                        onTap: () async => _lockDate = Timestamp.fromDate(
                          await showDatePicker(
                              context: context,
                              initialDate: isEditing
                                  ? args.vem.lockDate.toDate()
                                  : Vem.getDefaultStartDate().toDate(),
                              firstDate: Vem.getDefaultStartDate().toDate(),
                              lastDate: DateTime.now().add(Duration(days: 365))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue:
                              isEditing ? args.vem.minParticipants.toString() : '1',
                          decoration:
                              new InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red
                                    )
                                  ),
                                labelText: 'Min participants',
                                prefixIcon: Icon(Icons.people, color: theme.primaryColor,)
                              ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) => _minParticipants = int.tryParse(val),
                          validator: (val) {
                            if (val.isEmpty){
                              return 'Il doit avoir un minimum';
                            }
                            else return null;
                            // return int.tryParse(val) > _maxParticipants
                            //     ? 'The maximum needs to be higher than the minimum.'
                            //     : null;
                          },
                          onSaved: (value) => _minParticipants = int.tryParse(value),
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue:
                              isEditing ? args.vem.maxParticipants.toString() : '0',
                          decoration:
                              new InputDecoration(
                                  labelText: 'Max participants',
                                  prefixIcon: Icon(Icons.people, color: theme.primaryColor),
                              ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) => _maxParticipants = int.tryParse(val),
                          validator: (val) {
                            try{
                              return _minParticipants > _maxParticipants
                                  ? 'Minimum plus petit que max'
                                  : null;
                            }catch (e){
                              return null;
                            }
                          },
                          onSaved: (value) => _maxParticipants = int.tryParse(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 10,),
               Center(
                 child: Container(
                   width: MediaQuery.of(context).size.width*4/5,
                   decoration: BoxDecoration(
                     color: Colors.white
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Radio<String>(
                           value: ResponseTypes.Battery.toString(),
                           groupValue: _responseType,
                           onChanged: (String type){
                              _responseType = type.toString();
                           }),
                       Radio<String>(
                           value: ResponseTypes.Other.toString(),
                           groupValue: _responseType,
                           onChanged: (String type){
                              _responseType = type.toString();
                           }),
              //     ListTile(
              //       title: Text(ResponseTypes.Battery.toString()),
              //       leading: Radio<String>(
              //         value: ResponseTypes.Battery.toString(),
              //         groupValue: _responseType,
              //         onChanged: (String type) {
              //           _responseType = type.toString();
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: Text(ResponseTypes.Other.toString()),
              //       leading: Radio<String>(
              //         value: ResponseTypes.Other.toString(),
              //         groupValue: _responseType,
              //         onChanged: (String type) =>
              //             _responseType = type.toString(),
              //       ),
              //     ),
                    ],
                   ),
                 ),
               ),
              SizedBox(height: 15,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                style: theme.textTheme.bodyText1.copyWith(color: Colors.grey[600]),
                initialValue: isEditing
                    ? args.vem.description
                    : 'Describe what the VEM entails and requires.',
                decoration: new InputDecoration(
                  labelStyle: theme.textTheme.bodyText1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  filled: true,
                  fillColor: theme.primaryColor,
                ),
                onSaved: (value) => _description = value,
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

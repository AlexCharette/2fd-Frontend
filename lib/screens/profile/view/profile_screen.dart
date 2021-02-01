import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/users/bloc/users_bloc.dart';
import 'package:regimental_app/config/config.dart';
import 'package:regimental_app/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.selectedIndex});

  final int selectedIndex;
  static String routeName = Routes.profile;
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ProfileScreen(
              selectedIndex: 2,
            ));
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool cancelSaveButtonsAreVisible = false;
  bool isReadOnly = true;
  bool editButtonVisible = true;

  String _email;
  String _phone;
  String _icEmail;
  String _icPhoneNumber;
  String _twoIcEmail;
  String _twoIcPhoneNumber;

  @override
  Widget build(BuildContext context) {
    final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
    final _formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);

    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is CurrentUserLoaded) {
        final currentUser = state.currentUser;
        final detId = currentUser.detId.trim();
        print('det id: $detId');
        return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('detachments')
                .doc('$detId')
                .get()
                .then((doc) => doc),
            builder: (
              BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot,
            ) {
              print('$snapshot');
              if (snapshot.hasError) {
                return Text(
                  S.of(context).errorGeneric + ': ${snapshot.error}.',
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                print('snapshot data: ${snapshot.data.id}');
                Map<String, dynamic> detInfo = snapshot.data.data();
                _icEmail = detInfo['icEmail'];
                _icPhoneNumber = detInfo['icPhoneNumber'];
                _twoIcEmail = detInfo['twoIcEmail'];
                _twoIcPhoneNumber = detInfo['twoIcPhoneNumber'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${currentUser.initials}".toUpperCase(),
                              style: theme.textTheme.headline3,
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            readOnly: isReadOnly,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.email_outlined),
                              hintText: currentUser.email,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.5,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) => _email = value,
                            validator: (value) {
                              if (!EmailValidator.validate(value)) {
                                return S.of(context).inputErrorEmail;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            readOnly: isReadOnly,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.phone),
                              hintText: currentUser.phoneNumber,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.5,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  new RegExp(r'^[0-9]*$')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                            validator: (value) {
                              if (!phoneRegex.hasMatch(value)) {
                                return 'Numero Invalide'; // TODO remove hard-coded text
                              }
                              return null;
                            },
                            onChanged: (value) => _phone = value,
                          ),
                        ),
                        //TODO: l'information du detachement devrai etre dynamique
                        Text(
                          'DET:${detInfo['detName']}',
                          style: theme.textTheme.headline4,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(color: Colors.grey[800])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.email),
                                    Text(
                                      _icEmail,
                                      style: theme.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.phone),
                                    Text(
                                      _icPhoneNumber,
                                      style: theme.textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(color: Colors.grey[800])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.email),
                                    Text(
                                      _twoIcEmail,
                                      style: theme.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.phone),
                                    Text(
                                      _twoIcPhoneNumber,
                                      style: theme.textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: cancelSaveButtonsAreVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                  tooltip: S.of(context).buttonCancelChanges,
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 50,
                                    color: AppColors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      editButtonVisible = true;
                                      isReadOnly = true;
                                      cancelSaveButtonsAreVisible = false;
                                    });
                                  }),
                              IconButton(
                                  tooltip: S.of(context).buttonSaveChanges,
                                  icon: Icon(
                                    Icons.check_circle,
                                    size: 50,
                                    color: AppColors.buttonGreen,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<UsersBloc>(context).add(
                                      UpdateCurrentUser(
                                        currentUser.copyWith(
                                          email: _email,
                                          phoneNumber: _phone,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      editButtonVisible = true;
                                      isReadOnly = true;
                                      cancelSaveButtonsAreVisible = false;
                                    });
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // selectedIndex: widget.selectedIndex,
                );
              }
              return CircularProgressIndicator();
            });
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

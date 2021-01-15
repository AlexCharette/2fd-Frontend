import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/users/bloc/users_bloc.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/config/theme.dart';

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

  String email;
  String phone;

  @override
  Widget build(BuildContext context) {
    final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
    final _formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);

    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is CurrentUserLoaded) {
        var currentUser = state.currentUser;
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
                      "${currentUser.lastName} ${currentUser.lastThree}"
                          .toUpperCase(),
                      style: theme.textTheme.headline3,
                    ),
                    Visibility(
                      visible: editButtonVisible,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.white))),
                          onPressed: () {
                            setState(() {
                              editButtonVisible = false;
                              isReadOnly = false;
                              cancelSaveButtonsAreVisible = true;
                            });
                          },
                          child: Text(
                            "DEMANDER UN CHANGEMENT",
                            style: theme.textTheme.bodyText1
                                .copyWith(color: Colors.white),
                          )),
                    )
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
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (!EmailValidator.validate(value)) {
                        return 'Addresse courriel invalide';
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
                        return 'Numero Invalide';
                      }
                      return null;
                    },
                    onChanged: (value) => phone = value,
                  ),
                ),
                //TODO: l'information du detachement devrai etre dynamique
                Text(
                  'DET:${currentUser.detId}',
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
                      Text(
                        'IC: DOE 456',
                        style: theme.textTheme.headline4,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.email),
                            Text(
                              'moe.doe@hotmail.com',
                              style: theme.textTheme.headline6,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.phone),
                            Text(
                              '(514)434-2452',
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
                      Text(
                        '2IC: wassup 789',
                        style: theme.textTheme.headline4,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.email),
                            Text(
                              'wassup@hotmail.com',
                              style: theme.textTheme.headline6,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.phone),
                            Text(
                              '(514)695-3344',
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
                          tooltip: "Annuler les Changements",
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
                          tooltip: "Confirmer les Changements",
                          icon: Icon(
                            Icons.check_circle,
                            size: 50,
                            color: AppColors.buttonGreen,
                          ),
                          onPressed: () {
                            //TODO: perform the changes on the database
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
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

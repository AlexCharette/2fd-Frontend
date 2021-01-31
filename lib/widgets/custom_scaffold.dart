import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/screens.dart';
import 'package:vem_repository/vem_repository.dart' show Vem;

import 'custom_app_bar.dart';
import 'custom_bottom_app_bar.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final Widget floatingActionButtons;
  final PageController pageController;
  final String appBarTitle;
  final bool displayBottomAppBar;
  final bool displayBGImage;
  final int selectedIndex;

  CustomScaffold(
      {this.appBarTitle,
      this.body,
      this.pageController,
      this.displayBottomAppBar = true,
      this.selectedIndex = 0,
      this.floatingActionButtons,
      this.displayBGImage = true});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarTitle: widget.appBarTitle,
        ),
        endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white38),
          child: Drawer(
            child: ListView(
              children: [
                ListTile(
                  leading: TextButton(
                    child: Text(
                      'EN', // TODO replace with opposite of current locale
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onPressed: () {
                      //TODO actually change the language
                      print('english');
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  trailing: Text(
                    'VEMS',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => Navigator.of(context)
                      .pushAndRemoveUntil(HomeScreen.route(), (route) => false),
                ),
                ListTile(
                  trailing: Text(
                    'NOUVELLE VEM',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AddEditVemScreen.routeName,
                    arguments: AddEditVemScreenArguments(
                      null,
                      (
                        name,
                        startDate,
                        endDate,
                        lockDate,
                        responseType,
                        description,
                        minParticipants,
                        maxParticipants,
                      ) {
                        BlocProvider.of<VemsBloc>(context).add(AddVem(
                          Vem(
                            name,
                            responseType,
                            startDate: startDate,
                            endDate: endDate,
                            lockDate: lockDate,
                            description: description,
                            minParticipants: minParticipants,
                            maxParticipants: maxParticipants,
                          ),
                        ));
                      },
                      false,
                    ),
                  ),
                ),
                ListTile(
                    trailing: Text(
                      'MON PROFILE',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (widget.selectedIndex != 2) {
                        widget.pageController.animateToPage(
                          1, // TODO make this not hardcoded (index of profile screen)
                          duration: new Duration(milliseconds: 250),
                          curve: Curves.bounceInOut,
                        );
                        //Navigator.of(context).push(ProfileScreen.route());
                      }
                    }),
                ListTile(
                  trailing: Text(
                    'ME DÉCONNECTER',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested()),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.displayBottomAppBar
            ? CustomBottomAppBar(
                pageController: widget.pageController,
              )
            : null,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red, Colors.blue]),
                  image: widget.displayBGImage
                      ? DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          image: AssetImage('assets/images/tradition.jpg'),
                          fit: BoxFit.cover)
                      : null),
              child: SafeArea(child: widget.body)),
        ),
        floatingActionButton: widget.floatingActionButtons);
  }
}

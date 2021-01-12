import 'package:flutter/material.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = Routes.home;
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'VEMS',
      body: VemList(),
      floatingActionButtons: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        onPressed: () {
          //TODO: display other floating action buttons
        },
      ),
    );
  }
}

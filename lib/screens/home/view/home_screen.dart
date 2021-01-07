import 'package:flutter/material.dart';
import 'package:regimental_app/widgets/custom_scaffold.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

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
import 'package:flutter/material.dart';
import 'package:regimental_app/widgets/custom_scaffold.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'VEM',
      body: VemList(),
      floatingActionButtons: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        onPressed: (){
          //TODO: display other floating action buttons
        },
      ),
    );
  }
}

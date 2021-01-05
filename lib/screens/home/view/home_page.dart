import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:regimental_app/widgets/custom_app_bar.dart';
import 'package:regimental_app/widgets/custom_bottom_app_bar.dart';
import 'package:regimental_app/widgets/custom_scaffold.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: VemList()
    );
  }
}

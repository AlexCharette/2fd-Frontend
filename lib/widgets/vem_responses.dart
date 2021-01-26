import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';

class VemResponses extends StatelessWidget {
  final String vemId;

  const VemResponses({Key key, this.vemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VemResponsesBloc, VemResponsesState>(
      builder: (context, state) {
        if (state is ResponsesForVemLoading) {
          return CircularProgressIndicator();
        } else if (state is ResponsesForVemLoaded) {
          final responses = state.vemResponses;
          return GridView();
        }
      },
    );
  }
}

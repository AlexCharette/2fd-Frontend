import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/widgets/widgets.dart';

class VemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VemsBloc, VemsState>(
      builder: (context, state) {
        if (state is VemsLoading) {
          // return loading indicator
        } else if (state is VemsLoaded) {
          final vems = state.vems;
          return ListView.builder(
            itemCount: vems.length,
            itemBuilder: (context, index) {
              final vem = vems[index];
              return VemItem(
                vem: vem,
                onTap: () async {
                  // TODO
                  // if user type is permitted
                  // go to vem details screen
                },
                onLongPress: () async {
                  // TODO
                  if (Timestamp.now().compareTo(vem.lockDate) <= 0) {
                    // open vem response widget
                  } else {
                    // open response change request widget
                  }
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

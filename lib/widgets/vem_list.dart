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
                  // go to vem details screen
                },
                onLongPress: () async {
                  // TODO
                  // if it isn't full
                  final vemResponses = state.
                  // If the lock date has not passed
                  if (Timestamp.now().compareTo(vem.lockDate) <= 0) {
                    // open vem response widget
                    Overlay.of(context).insert(OverlayEntry(builder: (context) {
                      final size = MediaQuery.of(context).size;
                      return VemResponder(vem: vem);
                    }));
                  } else {
                    // open response change request widget
                  }
                  // else popup saying it's full
                  final snackBar = SnackBar(
                    content: Text(
                        'Maximum attendance for this VEM has been reached.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

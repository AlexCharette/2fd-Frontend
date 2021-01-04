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
      builder: (context, vemsState) {
        return BlocBuilder<VemResponsesBloc, VemResponsesState>(
          builder: (context, responsesState) {
            if (vemsState is VemsLoading ||
                responsesState is VemResponsesLoading) {
              // return loading indicator
            } else if (vemsState is VemsLoaded &&
                responsesState is VemResponsesLoaded) {
              final vems = vemsState.vems;
              final vemResponses = responsesState.vemResponses;
              return ListView.builder(
                itemCount: vems.length,
                itemBuilder: (context, index) {
                  final vem = vems[index];
                  return VemItem(
                    vem: vem,
                    vemResponses: vemResponses[vem.id],
                    onTap: () async {
                      // TODO
                      // go to vem details screen
                    },
                    onLongPress: () async {
                      // TODO
                      // if it isn't full
                      if (vemResponses.length < vem.maxParticipants) {
                        // If the lock date has not passed
                        if (Timestamp.now().compareTo(vem.lockDate) <= 0) {
                          // open vem response widget
                          Overlay.of(context)
                              .insert(OverlayEntry(builder: (context) {
                            final size = MediaQuery.of(context).size;
                            return VemResponder(vem: vem);
                          }));
                        } else {
                          // open response change request widget
                        }
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
      },
    );
  }
}

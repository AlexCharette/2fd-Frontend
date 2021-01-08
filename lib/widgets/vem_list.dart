import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/screens/vem_details/view/view.dart';
import 'package:regimental_app/widgets/widgets.dart';

class VemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VemsBloc, VemsState>(
      builder: (context, vemsState) {
        return BlocBuilder<VemResponsesBloc, VemResponsesState>(
          builder: (context, responsesState) {
            if (vemsState is VemsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (vemsState is VemsLoaded &&
                responsesState is VemResponsesLoaded) {
              final vems = vemsState.vems;
              final vemResponses = responsesState.vemResponses;
              if (vems.length > 0) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  itemCount: vems.length,
                  itemBuilder: (context, index) {
                    dynamic temp = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid ?? '');
                    final vem = vems[index];
                    return VemItem(
                      vem: vem,
                      vemResponses: vemResponses
                          .where((response) => response.vemId == vem.id)
                          .toList(),
                      onTap: () async {
                        // go to vem details screen
                        Navigator.pushNamed(
                          context,
                          VemDetailsScreen.routeName,
                          arguments: VemDetailsScreenArguments(vem),
                        );
                      },
                      onLongPress: () async {
                        // if it isn't full
                        if (vemResponses.length < vem.maxParticipants) {
                          // If the lock date has not passed
                          if (Timestamp.now().compareTo(vem.lockDate) <= 0) {
                            // open vem response widget
                            showDialog(
                              context: context,
                              builder: (context) => VemResponder(vem: vem),
                            );
                          } else {
                            // TODO open response change request widget
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
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

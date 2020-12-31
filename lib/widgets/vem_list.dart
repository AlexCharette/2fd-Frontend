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
                  // view vem if permitted by account type
                  // go to vem details screen
                },
                onLongPress: () async {
                  // TODO
                  // respond to vem if permitted by date
                  // open vem response widget
                },
              );
              // return vem item
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

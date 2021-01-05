import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:regimental_app/widgets/custom_app_bar.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(appBarTitle: 'VEMS',),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.red]
              ),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/second-fd-app.appspot.com/o/assets%2Fimages%2Ftradition.jpg?alt=media&token=cd2f7c47-e7c9-449b-83ee-75ae3faa7782'
                    ),
                    fit: BoxFit.cover
                )
            ),
              child: VemList()
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Builder(
          //       builder: (context) {
          //         final userId = context.select(
          //           (AuthenticationBloc bloc) => bloc.state.user.id,
          //         );
          //         return Text('UserID: $userId');
          //       },
          //     ),

          //     RaisedButton(
          //       child: const Text('Logout'),
          //       onPressed: () {
          //         context
          //             .read<AuthenticationBloc>()
          //             .add(AuthenticationLogoutRequested());
          //       },
          //     ),
          //   ],
          // ),
        ));
  }
}

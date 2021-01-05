import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/resetPassword/bloc/reset_password_bloc.dart';
import 'package:regimental_app/screens/reset_password/view/resetPasswordForm.dart';

class ResetPasswordPage extends StatelessWidget {
  static Route route(){
    return MaterialPageRoute<void>(builder: (_)=> ResetPasswordPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context){
          return ResetPasswordBloc(
              authenticationRepository: RepositoryProvider.of(context)
          );
        },
        child: ResetPasswordForm(),
      ),
    );
  }
}

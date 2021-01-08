import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/blocs/resetPassword/bloc/reset_password_bloc.dart';
import 'package:regimental_app/screens/reset_password/view/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = Routes.resetPassword;
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ResetPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return ResetPasswordBloc(
              authenticationRepository: RepositoryProvider.of(context));
        },
        child: ResetPasswordForm(),
      ),
    );
  }
}

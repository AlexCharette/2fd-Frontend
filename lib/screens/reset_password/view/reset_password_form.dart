import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:regimental_app/blocs/resetPassword/bloc/reset_password_bloc.dart';
import 'package:regimental_app/config/theme.dart';

class ResetPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state){
          if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Reset Password Failure')),
              );
          }
        },
      child: Center(
        child: Column(
          children: <Widget>[
            //TODO: Figure how to add a dynamic space instead of hard coding the space
            SizedBox(height: 100,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Mot de Passe',
                    style: theme.textTheme.headline2.copyWith(color: Colors.black)
                  ),
                ),
                Center(
                  child: Text(
                    'Oublié',
                    style: theme.textTheme.headline2.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(height: 50,),
            Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Entrez l\'adresse courriel associée',
                    style: theme.textTheme.bodyText1,
                  ),
                ),
                Center(
                  child: Text(
                    'à votre compte',
                    style: theme.textTheme.bodyText1,
                  ),
                )
              ],
            ),
            SizedBox(height:12.0),
            _UsernameInput(),
            Flexible(child: Align(alignment: Alignment.bottomCenter, child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: _ResetPassword(),
            ),)),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.charcoal)
                ),
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: 300,
          child: TextField(
            key: const Key('resetForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<ResetPasswordBloc>().add(ResetPasswordEmailChanged(username)),
            decoration: InputDecoration(
              hintText: 'Adresse Courriel',
              hintStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5,
              ),
              border: const OutlineInputBorder(),
              errorText: state.email.invalid ? 'Adresse Courriel invalide' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonGreen),
              minimumSize: MaterialStateProperty.all<Size>(Size(150,60)),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          child: Text(
            'ENVOYER',
            style: TextStyle(
                color : Colors.white,
                fontSize: 20,
                letterSpacing: 1.5
            ),
          ),
          onPressed: state.status.isValidated
              ? () {
            context.read<ResetPasswordBloc>().add(const ResetPasswordSubmitted());
            Navigator.pop(context);
          }
              : null,
        );
      },
    );
  }
}
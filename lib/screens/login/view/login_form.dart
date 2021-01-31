import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:regimental_app/blocs/LogIn/bloc/login_bloc.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/generated/l10n.dart';
import 'package:regimental_app/screens/reset_password/reset_password.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(S.of(context).errorAuthenticationSubmission)),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 250,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xffc7c94b6),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage('assets/images/GunDet.jpg'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).titleRegimentName,
                      style: TextStyle(
                        fontFamily: 'CastIron',
                        color: AppColors.white,
                        letterSpacing: 2.0,
                        fontSize: 70,
                      ),
                    ),
                    Text(
                      S.of(context).titleLogin,
                      style: TextStyle(
                          fontFamily: 'CastIron',
                          color: AppColors.white,
                          letterSpacing: 2.0,
                          fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _UsernameInput(),
                  SizedBox(
                    height: 12.0,
                  ),
                  _PasswordInput(),
                  SizedBox(
                    height: 5,
                  ),
                  _ForgotPasswordButton(),
                  Flexible(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: _LoginButton(),
                          )))
                ],
              )),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          width: 300,
          child: TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              hintText: S.of(context).inputHintEmail,
              hintStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5,
              ),
              border: const OutlineInputBorder(),
              errorText:
                  state.username.invalid ? S.of(context).inputErrorEmail : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: 300,
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: true,
            decoration: InputDecoration(
              hintText: S.of(context).inputHintPassword,
              hintStyle: TextStyle(fontSize: 16, letterSpacing: 1.5),
              border: const OutlineInputBorder(),
              errorText: state.password.invalid
                  ? S.of(context).inputErrorPassword
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_forgotPassword_textButton'),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.charcoal),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          side: MaterialStateProperty.all(
              BorderSide(color: AppColors.buttonOrange, width: 1.8))),
      child: Text(
        S.of(context).buttonForgotPassword,
        style: TextStyle(
            letterSpacing: 0.5, fontSize: 12, color: AppColors.buttonOrange),
      ),
      onPressed: () {
        Navigator.pushNamed(context, ResetPasswordScreen.routeName);
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.buttonGreen),
                    minimumSize: MaterialStateProperty.all<Size>(Size(150, 60)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: Text(
                  S.of(context).buttonSubmit,
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1.5),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

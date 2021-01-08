import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:regimental_app/blocs/LogIn/bloc/login_bloc.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/screens/reset_password/reset_password.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
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
                      '2RAC',
                      style: TextStyle(
                        fontFamily: 'CastIron',
                        color: AppColors.white,
                        letterSpacing: 2.0,
                        fontSize: 70,
                      ),
                    ),
                    Text(
                      'PORTAIL RÉGIMENTAIRE',
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
              hintText: 'Adresse Courriel',
              hintStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5,
              ),
              border: const OutlineInputBorder(),
              errorText:
                  state.username.invalid ? 'Adresse Courriel invalide' : null,
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
              hintText: 'Mot de Passe',
              hintStyle: TextStyle(fontSize: 16, letterSpacing: 1.5),
              border: const OutlineInputBorder(),
              errorText: state.password.invalid ? 'Mot de pass invalide' : null,
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
        'J\'ai oublié mon mot de passe',
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
                  'SOUMETTRE',
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

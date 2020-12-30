import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/screens/login/bloc/login_bloc.dart';
import 'package:regimental_app/screens/requestOneTimeCode/request_one_time_code.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffc7c94b6),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                image: NetworkImage(
                    'https://i.insider.com/5bc74da7ea92b129cc45d639?width=1136&format=jpeg'
                ),
                fit: BoxFit.fill
              )
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:20),
                child: Column(
                 children: <Widget>[
                   Text(
                     '2RAC',
                     style: TextStyle(
                       color : Colors.white,
                       letterSpacing: 2.0,
                       fontSize: 70
                     ),
                   ),
                   Text(
                     'PORTAIL RÉGIMENTAIRE',
                     style: TextStyle(
                      color : Colors.white,
                      letterSpacing: 2.0,
                      fontSize:  25
                     ),
                   )
                 ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          _UsernameInput(),
          SizedBox(height: 12.0,),
          _PasswordInput(),
          SizedBox(height: 5,),
          _ForgotPasswordButton(),
          Expanded(child: Align(alignment: Alignment.bottomCenter,child: Padding(
            padding: const EdgeInsets.only(bottom:20.0),
            child: _LoginButton(),
          )))
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
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            hintText: 'Adresse Courriel',
            hintStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5
            ),
            errorText: state.username.invalid ? 'Adresse Courriel invalide' : null,
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
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Mot de Passe',
            hintStyle: TextStyle(
              fontSize: 16,
              letterSpacing: 1.5
            ),
            errorText: state.password.invalid ? 'Mot de pass invalide' : null,
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
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: Colors.orange)
        ))

      ),
      child: const Text(
        'J\'ai oublié mon mot de passe',
        style: TextStyle(
          fontSize: 12,
          color: Colors.orange
        ),
      ),
      onPressed: (){
        Navigator.push(context, RequestOneTimeCodePage.route());
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green[500]),
                  minimumSize: MaterialStateProperty.all<Size>(Size(150,60)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                child: const Text(
                    'SOUMETTRE',
                  style: TextStyle(
                    color : Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.5
                  ),
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

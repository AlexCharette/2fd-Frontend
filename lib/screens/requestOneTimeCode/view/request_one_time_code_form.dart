import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/screens/requestOneTimeCode/bloc/request_one_time_code_bloc.dart';
import 'package:formz/formz.dart';

class RequestOneTimeCodeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestOneTimeCodeBloc, RequestOneTimeCodeState>(
      listener: (context, state){

      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 100, 5, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Mot de Passe Oublié',
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 2.0
              ),
              textAlign: TextAlign.center
            ),
            SizedBox(height: 70,),
            Center(
              child: Text(
                'Entrez l\'adresse courriel associée à votre compte',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10,),
            _UsernameInput(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _SendOneTimeCodeButton(),
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
    return BlocBuilder<RequestOneTimeCodeBloc, RequestOneTimeCodeState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state){
        return TextField(
          key: const Key('requestOneTimeCode_usernameInput_textField'),
          onChanged: (username) =>
              context.read<RequestOneTimeCodeBloc>().add(RequestOneTimeCodeUsernameChanged(username: username)),
          decoration: InputDecoration(
            hintText: 'Adresse Courriel',
            hintStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5
            ),
            errorText: state.email?.invalid == true ? 'Adresse Courriel invalide' : null,
          ),
        );
      },
    );
  }
}
class _SendOneTimeCodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestOneTimeCodeBloc, RequestOneTimeCodeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('requestOneTimeCode_continue_raisedButton'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green[500]),
              minimumSize: MaterialStateProperty.all<Size>(Size(150,60)),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          child: const Text(
            'ENVOYER',
            style: TextStyle(
                color : Colors.white,
                fontSize: 20,
                letterSpacing: 1.5
            ),
          ),
          onPressed: state.status.isValidated
              ? () {
            context.read<RequestOneTimeCodeBloc>().add(const RequestOneTimeCodeSubmitted());
          }
              : null,
        );
      },
    );
  }
}

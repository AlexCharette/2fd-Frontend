import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/repos/authentication_repository.dart';
import 'package:regimental_app/screens/requestOneTimeCode/bloc/request_one_time_code_bloc.dart';
import 'package:regimental_app/screens/requestOneTimeCode/view/request_one_time_code_form.dart';

class RequestOneTimeCodePage extends StatelessWidget {
  static Route route(){
    return MaterialPageRoute(builder: (_)=> RequestOneTimeCodePage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
            create: (context){
              return RequestOneTimeCodeBloc(
                  authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
          child: RequestOneTimeCodeForm(),
        ),
      ),
    );
  }
}

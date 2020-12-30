import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:regimental_app/repos/authentication_repository.dart';
import 'package:regimental_app/repos/models/models.dart';

part 'request_one_time_code_event.dart';
part 'request_one_time_code_state.dart';

class RequestOneTimeCodeBloc extends Bloc<RequestOneTimeCodeEvent,RequestOneTimeCodeState>{
  RequestOneTimeCodeBloc({@required AuthenticationRepository authenticationRepository}) : assert(authenticationRepository != null), _authenticationRepository=authenticationRepository, super(const RequestOneTimeCodeState());

  final AuthenticationRepository _authenticationRepository;
  @override
  Stream<RequestOneTimeCodeState> mapEventToState(RequestOneTimeCodeEvent event) async* {
    if (event is RequestOneTimeCodeUsernameChanged){
      yield _mapUsernameChangedToState(event, state);
    }
    else if( event is RequestOneTimeCodeSubmitted){
      yield* _mapSubmittedToState(event, state);
    }
  }

  RequestOneTimeCodeState _mapUsernameChangedToState(RequestOneTimeCodeUsernameChanged event, RequestOneTimeCodeState state) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      email: username,
      status: Formz.validate([username])
    );
  }

  Stream<RequestOneTimeCodeState>_mapSubmittedToState(RequestOneTimeCodeSubmitted event, RequestOneTimeCodeState state) async* {
    if (state.status.isValidated){
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try{
        await _authenticationRepository.requestOneTimeCode(username: state.email.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }catch(e){
        print(e.toString());
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

}
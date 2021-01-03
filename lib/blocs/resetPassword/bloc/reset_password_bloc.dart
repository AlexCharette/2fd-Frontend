import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  ResetPasswordBloc({@required AuthenticationRepository authenticationRepository}) : assert(authenticationRepository !=null ), _authenticationRepository= authenticationRepository, super(const ResetPasswordState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async*{
    if (event is ResetPasswordEmailChanged){
      yield _mapEmailChangedToState(event, state);
    }
    else if (event is ResetPasswordSubmitted){
     yield* _mapResetPasswordSubmittedToState(event,state);
    }
  }

  ResetPasswordState _mapEmailChangedToState(ResetPasswordEmailChanged event, ResetPasswordState state){
    final email = Username.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<ResetPasswordState> _mapResetPasswordSubmittedToState(ResetPasswordSubmitted event, ResetPasswordState state) async*{
    print("before validate");
    if (state.status.isValidated){
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try{
        print("calling rest");
        await _authenticationRepository.resetPassword(username: state.email.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }catch(e){
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

}
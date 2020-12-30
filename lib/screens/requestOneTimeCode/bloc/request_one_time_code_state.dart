part of 'request_one_time_code_bloc.dart';

class RequestOneTimeCodeState extends Equatable{
  const RequestOneTimeCodeState({ this.status, this.email});

  final FormzStatus status;
  final Username email;

  RequestOneTimeCodeState copyWith({FormzStatus status, Username email}){
    return RequestOneTimeCodeState(
      status: status ?? this.status,
      email: email ?? this.email
    );
  }
  @override
  List<Object> get props => [status, email];

}
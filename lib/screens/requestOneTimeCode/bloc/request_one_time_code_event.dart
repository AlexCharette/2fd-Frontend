part of 'request_one_time_code_bloc.dart';

abstract class RequestOneTimeCodeEvent extends Equatable{
  const RequestOneTimeCodeEvent();

  @override
  List<Object> get props => [];
}

class RequestOneTimeCodeUsernameChanged extends RequestOneTimeCodeEvent{
  const RequestOneTimeCodeUsernameChanged({ this.username });

  final String username;

  @override
  List<Object> get props => [username];
}

class RequestOneTimeCodeSubmitted extends RequestOneTimeCodeEvent{
  const RequestOneTimeCodeSubmitted();
}
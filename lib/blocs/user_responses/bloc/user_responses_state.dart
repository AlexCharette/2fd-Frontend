part of 'user_responses_bloc.dart';

abstract class UserResponsesState extends Equatable {
  const UserResponsesState();

  @override
  List<Object> get props => [];
}

class UserResponsesLoading extends UserResponsesState {}

class UserResponsesLoaded extends UserResponsesState {
  final List<VemResponse> responses;

  const UserResponsesLoaded(this.responses);

  @override
  List<Object> get props => [responses];

  @override
  String toString() => 'UserResponsesLoaded { UserResponses: $responses }';
}

class UserResponsesNotLoaded extends UserResponsesState {}

part of 'user_responses_bloc.dart';

abstract class UserResponsesEvent extends Equatable {
  const UserResponsesEvent();

  @override
  List<Object> get props => [];
}

class LoadUserResponses extends UserResponsesEvent {}

class LoadResponsesForUser extends UserResponsesEvent {
  final String userId;

  const LoadResponsesForUser(this.userId);

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'LoadResponsesForUser { responsesForUser: $userId }';
}

class AddUserResponse extends UserResponsesEvent {
  final VemResponse vemResponse;

  const AddUserResponse(this.vemResponse);

  @override
  List<Object> get props => [vemResponse];

  @override
  String toString() => 'AddUserResponse { userResponse: $vemResponse }';
}

class UpdateUserResponse extends UserResponsesEvent {
  final VemResponse updatedVemResponse;

  const UpdateUserResponse(this.updatedVemResponse);

  @override
  List<Object> get props => [updatedVemResponse];

  @override
  String toString() =>
      'UpdateUserResponse { updatedUserResponse: $updatedVemResponse }';
}

class UserResponsesUpdated extends UserResponsesEvent {
  final List<VemResponse> userResponses;

  const UserResponsesUpdated(this.userResponses);

  @override
  List<Object> get props => [userResponses];
}

class AddResponseChange extends UserResponsesEvent {
  final ResponseChange responseChange;

  const AddResponseChange(this.responseChange);

  @override
  List<Object> get props => [responseChange];

  @override
  String toString() => 'AddResponseChange { responseChange: $responseChange }';
}

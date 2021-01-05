part of 'users_bloc.dart';

class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {}

class LoadCurrentUser extends UsersEvent {}

class UpdateCurrentUser extends UsersEvent {
  final User updatedUser;

  const UpdateCurrentUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];

  @override
  String toString() => 'UpdateCurrentUser { updatedUser: $updatedUser }';
}

class UsersUpdated extends UsersEvent {
  final List<User> users;

  const UsersUpdated(this.users);

  @override
  List<Object> get props => [users];
}

class CurrentUserUpdated extends UsersEvent {
  final User currentUser;

  const CurrentUserUpdated(this.currentUser);

  @override
  List<Object> get props => [currentUser];
}

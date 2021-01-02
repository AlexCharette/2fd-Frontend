part of 'users_bloc.dart';

class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {}

class UpdateUser extends UsersEvent {
  final User updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];

  @override
  String toString() => 'UpdateUser { updatedUser: $updatedUser }';
}

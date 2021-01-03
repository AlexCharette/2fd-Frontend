part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;

  const UsersLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'VemsLoaded { vems: $users }';
}

class UsersNotLoaded extends UsersState {}

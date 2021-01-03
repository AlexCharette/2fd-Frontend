import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository;
  StreamSubscription _usersSubscription;

  UsersBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(UsersLoading());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadUsers) {
      yield* _mapLoadUsersToState(event);
    } else if (event is UpdateCurrentUser) {
      yield* _mapUpdateCurrentUserToState(event);
    }
  }

  Stream<UsersState> _mapLoadUsersToState(LoadUsers event) async* {
    _usersSubscription?.cancel();
    _usersSubscription =
        _userRepository.users().listen((users) => add(UsersUpdated(users)));
  }

  Stream<UsersState> _mapUpdateCurrentUserToState(
      UpdateCurrentUser event) async* {
    _userRepository.updateUser(event.updatedUser);
  }
}

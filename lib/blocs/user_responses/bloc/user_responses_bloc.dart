import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

part 'user_responses_event.dart';
part 'user_responses_state.dart';

class UserResponsesBloc extends Bloc<UserResponsesEvent, UserResponsesState> {
  final VemResponseRepository _vemResponseRepository;
  StreamSubscription _userResponsesSubscription;

  UserResponsesBloc({@required VemResponseRepository vemResponseRepository})
      : assert(vemResponseRepository != null),
        _vemResponseRepository = vemResponseRepository,
        super(UserResponsesLoading());

  @override
  Stream<UserResponsesState> mapEventToState(UserResponsesEvent event) async* {
    if (event is LoadResponsesForUser) {
      yield* _mapLoadUserResponsesToState(event);
    } else if (event is AddUserResponse) {
      yield* _mapAddVemResponseToState(event);
    } else if (event is UpdateUserResponse) {
      yield* _mapUpdateVemResponseToState(event);
    } else if (event is UserResponsesUpdated) {
      yield* _mapUserResponsesUpdatedToState(event);
    } else if (event is AddResponseChange) {
      yield* _mapAddResponseChangeToState(event);
    }
  }

  Stream<UserResponsesState> _mapLoadUserResponsesToState(
      LoadResponsesForUser event) async* {
    _userResponsesSubscription?.cancel();
    _userResponsesSubscription = _vemResponseRepository
        .responsesForUser(event.userId)
        .listen((userResponses) => add(UserResponsesUpdated(userResponses)));
  }

  Stream<UserResponsesState> _mapAddVemResponseToState(
      AddUserResponse event) async* {
    _vemResponseRepository.addVemResponse(event.vemResponse);
  }

  Stream<UserResponsesState> _mapUpdateVemResponseToState(
      UpdateUserResponse event) async* {
    _vemResponseRepository.updateVemResponse(event.updatedVemResponse);
  }

  Stream<UserResponsesState> _mapUserResponsesUpdatedToState(
      UserResponsesUpdated event) async* {
    yield UserResponsesLoaded(event.UserResponses);
  }

  Stream<UserResponsesState> _mapAddResponseChangeToState(
      AddResponseChange event) async* {
    _vemResponseRepository.addResponseChange(event.responseChange);
  }

  @override
  Future<void> close() {
    _userResponsesSubscription?.cancel();
    return super.close();
  }
}

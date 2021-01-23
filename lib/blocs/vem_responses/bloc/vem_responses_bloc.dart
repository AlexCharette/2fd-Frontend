import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

part 'vem_responses_event.dart';
part 'vem_responses_state.dart';

class VemResponsesBloc extends Bloc<VemResponsesEvent, VemResponsesState> {
  final VemResponseRepository _vemResponseRepository;
  StreamSubscription _vemResponsesSubscription;

  VemResponsesBloc({@required VemResponseRepository vemResponseRepository})
      : assert(vemResponseRepository != null),
        _vemResponseRepository = vemResponseRepository,
        super(VemResponsesLoading());

  @override
  Stream<VemResponsesState> mapEventToState(VemResponsesEvent event) async* {
    if (event is LoadVemResponses) {
      yield* _mapLoadVemResponsesToState();
    } else if (event is LoadResponsesForUser) {
      yield* _mapLoadUserResponsesToState(event);
    } else if (event is LoadResponsesForVem) {
      yield* _mapLoadResponsesForVemToState(event);
    } else if (event is AddVemResponse) {
      yield* _mapAddVemResponseToState(event);
    } else if (event is UpdateVemResponse) {
      yield* _mapUpdateVemResponseToState(event);
    } else if (event is VemResponsesUpdated) {
      yield* _mapVemResponsesUpdatedToState(event);
    } else if (event is UserResponsesUpdated) {
      yield* _mapUserResponsesUpdatedToState(event);
    } else if (event is AddResponseChange) {
      yield* _mapAddResponseChangeToState(event);
    }
  }

  Stream<VemResponsesState> _mapLoadVemResponsesToState() async* {
    _vemResponsesSubscription?.cancel();
    _vemResponsesSubscription = _vemResponseRepository
        .vemResponses()
        .listen((vemResponses) => add(VemResponsesUpdated(vemResponses)));
  }

  Stream<VemResponsesState> _mapLoadUserResponsesToState(
      LoadResponsesForUser event) async* {
    _vemResponsesSubscription?.cancel();
    _vemResponsesSubscription = _vemResponseRepository
        .responsesForUser(event.userId)
        .listen((vemResponses) => add(UserResponsesUpdated(vemResponses)));
  }

  Stream<VemResponsesState> _mapLoadResponsesForVemToState(
      LoadResponsesForVem event) async* {
    _vemResponsesSubscription?.cancel();
    _vemResponsesSubscription = _vemResponseRepository
        .responsesForVem(event.vemId)
        .listen((vemResponses) => add(VemResponsesUpdated(vemResponses)));
  }

  Stream<VemResponsesState> _mapAddVemResponseToState(
      AddVemResponse event) async* {
    _vemResponseRepository.addVemResponse(event.vemResponse);
  }

  Stream<VemResponsesState> _mapUpdateVemResponseToState(
      UpdateVemResponse event) async* {
    _vemResponseRepository.updateVemResponse(event.updatedVemResponse);
  }

  Stream<VemResponsesState> _mapVemResponsesUpdatedToState(
      VemResponsesUpdated event) async* {
    yield VemResponsesLoaded(event.vemResponses);
  }

  Stream<VemResponsesState> _mapUserResponsesUpdatedToState(
      UserResponsesUpdated event) async* {
    yield UserResponsesLoaded(event.vemResponses);
  }

  Stream<VemResponsesState> _mapAddResponseChangeToState(
      AddResponseChange event) async* {
    _vemResponseRepository.addResponseChange(event.responseChange);
  }

  @override
  Future<void> close() {
    _vemResponsesSubscription?.cancel();
    return super.close();
  }
}

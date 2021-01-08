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
    } else if (event is AddVemResponse) {
      yield* _mapAddVemResponseToState(event);
    } else if (event is UpdateVemResponse) {
      yield* _mapUpdateVemResponseToState(event);
    } else if (event is VemResponsesUpdated) {
      yield* _mapVemResponsesUpdatedToState(event);
    }
  }

  Stream<VemResponsesState> _mapLoadVemResponsesToState() async* {
    _vemResponsesSubscription?.cancel();
    _vemResponsesSubscription = _vemResponseRepository
        .vemResponses()
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

  @override
  Future<void> close() {
    _vemResponsesSubscription?.cancel();
    return super.close();
  }
}

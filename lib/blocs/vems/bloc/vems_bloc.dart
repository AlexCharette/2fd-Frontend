import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vem_repository/vem_repository.dart';

part 'vems_event.dart';
part 'vems_state.dart';

class VemsBloc extends Bloc<VemsEvent, VemsState> {
  final VemRepository _vemRepository;
  StreamSubscription _vemsSubscription;

  VemsBloc({@required VemRepository vemRepository})
      : assert(vemRepository != null),
        _vemRepository = vemRepository,
        super(VemsLoading());

  @override
  Stream<VemsState> mapEventToState(VemsEvent event) async* {
    if (event is LoadVems) {
      yield* _mapLoadVemsToState();
    } else if (event is AddVem) {
      yield* _mapAddVemToState(event);
    } else if (event is UpdateVem) {
      yield* _mapUpdateVemToState(event);
    } else if (event is DeleteVem) {
      yield* _mapDeleteVemToState(event);
    } else if (event is VemsUpdated) {
      yield* _mapVemsUpdatedToState(event);
    } else if (event is LoadVemResponses) {
      yield* _mapLoadVemResponsesToState();
    } else if (event is AddVemResponse) {
      yield* _mapAddVemResponseToState(event);
    } else if (event is UpdateVemResponse) {
      yield* _mapUpdateVemResponseToState(event);
    } else if (event is VemResponsesUpdated) {
      yield* _mapVemResponsesUpdatedToState(event);
    }
  }

  Stream<VemsState> _mapLoadVemsToState() async* {
    _vemsSubscription?.cancel();
    _vemsSubscription =
        _vemRepository.vems().listen((vems) => add(VemsUpdated(vems)));
  }

  Stream<VemsState> _mapAddVemToState(AddVem event) async* {
    _vemRepository.addNewVem(event.vem);
  }

  Stream<VemsState> _mapUpdateVemToState(UpdateVem event) async* {
    _vemRepository.updateVem(event.updatedVem);
  }

  Stream<VemsState> _mapDeleteVemToState(DeleteVem event) async* {
    _vemRepository.deleteVem(event.vem);
  }

  Stream<VemsState> _mapVemsUpdatedToState(VemsUpdated event) async* {
    yield VemsLoaded(event.vems);
  }

  // VEM Responses

  Stream<VemsState> _mapLoadVemResponsesToState() async* {
    _vemsSubscription?.cancel();
    _vemsSubscription = _vemRepository
        .vemResponses()
        .listen((vemResponses) => add(VemResponsesUpdated(vemResponses)));
  }

  Stream<VemsState> _mapAddVemResponseToState(AddVemResponse event) async* {
    _vemRepository.addVemResponse(event.vemId, event.vemResponse);
  }

  Stream<VemsState> _mapUpdateVemResponseToState(
      UpdateVemResponse event) async* {
    _vemRepository.updateVemResponse(event.vemId, event.updatedVemResponse);
  }

  Stream<VemsState> _mapVemResponsesUpdatedToState(
      VemResponsesUpdated event) async* {
    yield VemResponsesLoaded(event.vemResponses);
  }

  @override
  Future<void> close() {
    _vemsSubscription?.cancel();
    return super.close();
  }
}

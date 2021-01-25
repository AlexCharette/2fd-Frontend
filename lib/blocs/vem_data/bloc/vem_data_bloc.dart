import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

part 'vem_data_event.dart';
part 'vem_data_state.dart';

// class VemsBloc extends Bloc<VemsEvent, VemsState> {
//   final VemRepository _vemRepository;
//   StreamSubscription _vemsSubscription;

//   VemsBloc({@required VemRepository vemRepository})
//       : assert(vemRepository != null),
//         _vemRepository = vemRepository,
//         super(VemsLoading());

//   @override
//   Stream<VemsState> mapEventToState(VemsEvent event) async* {
//     if (event is LoadVems) {
//       yield* _mapLoadVemsToState();
//     } else if (event is AddVem) {
//       yield* _mapAddVemToState(event);
//     } else if (event is UpdateVem) {
//       yield* _mapUpdateVemToState(event);
//     } else if (event is DeleteVem) {
//       yield* _mapDeleteVemToState(event);
//     } else if (event is VemsUpdated) {
//       yield* _mapVemsUpdatedToState(event);
//     } else if (event is VemsRefreshRequested) {
//       yield* _mapVemsRefreshRequestedToState(event);
//     }
//   }

//   Stream<VemsState> _mapLoadVemsToState() async* {
//     _vemsSubscription?.cancel();
//     _vemsSubscription = _vemRepository.vems().listen(
//           (vems) => add(VemsUpdated(vems)),
//         );
//   }

//   Stream<VemsState> _mapAddVemToState(AddVem event) async* {
//     _vemRepository.addNewVem(event.vem);
//   }

//   Stream<VemsState> _mapUpdateVemToState(UpdateVem event) async* {
//     _vemRepository.updateVem(event.updatedVem);
//   }

//   Stream<VemsState> _mapDeleteVemToState(DeleteVem event) async* {
//     _vemRepository.deleteVem(event.vem);
//   }

//   Stream<VemsState> _mapVemsUpdatedToState(VemsUpdated event) async* {
//     yield VemsLoaded(event.vems);
//   }

//   Stream<VemsState> _mapVemsRefreshRequestedToState(
//       VemsRefreshRequested event) async* {
//     add(LoadVems());
//   }

//   @override
//   Future<void> close() {
//     _vemsSubscription?.cancel();
//     return super.close();
//   }
// }

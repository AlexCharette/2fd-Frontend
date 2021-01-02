part of 'vems_bloc.dart';

abstract class VemsEvent extends Equatable {
  const VemsEvent();

  @override
  List<Object> get props => [];
}

class LoadVems extends VemsEvent {}

class AddVem extends VemsEvent {
  final Vem vem;

  const AddVem(this.vem);

  @override
  List<Object> get props => [vem];

  @override
  String toString() => 'AddVem { vem: $vem }';
}

class UpdateVem extends VemsEvent {
  final Vem updatedVem;

  const UpdateVem(this.updatedVem);

  @override
  List<Object> get props => [updatedVem];

  @override
  String toString() => 'UpdateVem { updatedVem: $updatedVem }';
}

class DeleteVem extends VemsEvent {
  final Vem vem;

  const DeleteVem(this.vem);

  @override
  List<Object> get props => [vem];

  @override
  String toString() => 'DeleteVem { vem: $vem }';
}

class VemsUpdated extends VemsEvent {
  final List<Vem> vems;

  const VemsUpdated(this.vems);

  @override
  List<Object> get props => [vems];
}

class LoadVemResponses extends VemsEvent {}

class AddVemResponse extends VemsEvent {
  final String vemId;
  final VemResponse vemResponse;

  const AddVemResponse(this.vemId, this.vemResponse);

  @override
  List<Object> get props => [vemResponse];

  @override
  String toString() =>
      'AddVemResponse { vemId: $vemId, vemResponse: $vemResponse }';
}

class UpdateVemResponse extends VemsEvent {
  final String vemId;
  final VemResponse updatedVemResponse;

  const UpdateVemResponse(this.vemId, this.updatedVemResponse);

  @override
  List<Object> get props => [vemId, updatedVemResponse];

  @override
  String toString() =>
      'UpdateVemResponse { vemId: $vemId, updatedVemResponse: $updatedVemResponse }';
}

class VemResponsesUpdated extends VemsEvent {
  final List<VemResponse> vemResponses;

  const VemResponsesUpdated(this.vemResponses);

  @override
  List<Object> get props => [vemResponses];
}

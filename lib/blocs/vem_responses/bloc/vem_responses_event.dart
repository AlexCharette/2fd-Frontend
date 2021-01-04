part of 'vem_responses_bloc.dart';

abstract class VemResponsesEvent extends Equatable {
  const VemResponsesEvent();

  @override
  List<Object> get props => [];
}

class LoadVemResponses extends VemResponsesEvent {}

class AddVemResponse extends VemResponsesEvent {
  final String vemId;
  final VemResponse vemResponse;

  const AddVemResponse(this.vemId, this.vemResponse);

  @override
  List<Object> get props => [vemResponse];

  @override
  String toString() =>
      'AddVemResponse { vemId: $vemId, vemResponse: $vemResponse }';
}

class UpdateVemResponse extends VemResponsesEvent {
  final String vemId;
  final VemResponse updatedVemResponse;

  const UpdateVemResponse(this.vemId, this.updatedVemResponse);

  @override
  List<Object> get props => [vemId, updatedVemResponse];

  @override
  String toString() =>
      'UpdateVemResponse { vemId: $vemId, updatedVemResponse: $updatedVemResponse }';
}

class VemResponsesUpdated extends VemResponsesEvent {
  final Map<String, List<VemResponse>> vemResponses;

  const VemResponsesUpdated(this.vemResponses);

  @override
  List<Object> get props => [vemResponses];
}

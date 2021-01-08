part of 'vem_responses_bloc.dart';

abstract class VemResponsesEvent extends Equatable {
  const VemResponsesEvent();

  @override
  List<Object> get props => [];
}

class LoadVemResponses extends VemResponsesEvent {}

class AddVemResponse extends VemResponsesEvent {
  final VemResponse vemResponse;

  const AddVemResponse(this.vemResponse);

  @override
  List<Object> get props => [vemResponse];

  @override
  String toString() => 'AddVemResponse { vemResponse: $vemResponse }';
}

class UpdateVemResponse extends VemResponsesEvent {
  final VemResponse updatedVemResponse;

  const UpdateVemResponse(this.updatedVemResponse);

  @override
  List<Object> get props => [updatedVemResponse];

  @override
  String toString() =>
      'UpdateVemResponse { updatedVemResponse: $updatedVemResponse }';
}

class VemResponsesUpdated extends VemResponsesEvent {
  final List<VemResponse> vemResponses;

  const VemResponsesUpdated(this.vemResponses);

  @override
  List<Object> get props => [vemResponses];
}

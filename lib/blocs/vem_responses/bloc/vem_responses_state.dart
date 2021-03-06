part of 'vem_responses_bloc.dart';

abstract class VemResponsesState extends Equatable {
  const VemResponsesState();

  @override
  List<Object> get props => [];
}

class VemResponsesLoading extends VemResponsesState {}

class VemResponsesLoaded extends VemResponsesState {
  final List<VemResponse> vemResponses;

  const VemResponsesLoaded(this.vemResponses);

  @override
  List<Object> get props => [vemResponses];

  @override
  String toString() => 'VemResponsesLoaded { vemResponses: $vemResponses }';
}

class ResponsesForVemLoading extends VemResponsesState {}

class ResponsesForVemLoaded extends VemResponsesState {
  final List<VemResponse> vemResponses;
  final String vemId;

  const ResponsesForVemLoaded(this.vemResponses, this.vemId);

  @override
  List<Object> get props => [vemResponses, vemId];

  @override
  String toString() =>
      'VemResponsesLoaded { vemResponses: $vemResponses, vemId: $vemId }';
}

class VemResponsesNotLoaded extends VemResponsesState {}

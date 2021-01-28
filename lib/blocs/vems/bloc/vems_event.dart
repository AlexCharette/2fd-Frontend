part of 'vems_bloc.dart';

abstract class VemsEvent extends Equatable {
  const VemsEvent();

  @override
  List<Object> get props => [];
}

class LoadVemListData extends VemsEvent {}

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

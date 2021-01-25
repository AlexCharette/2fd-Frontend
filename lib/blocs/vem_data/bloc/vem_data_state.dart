part of 'vem_data_bloc.dart';

abstract class VemDataState extends Equatable {
  const VemDataState();

  @override
  List<Object> get props => [];
}

class AppStarted extends VemDataState {}

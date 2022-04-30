part of 'onye_bloc.dart';

abstract class OnyeState extends Equatable {
  const OnyeState();
  
  @override
  List<Object> get props => [];
}

class OnyeInitial extends OnyeState {}
class OnyeLoaded extends OnyeState {}

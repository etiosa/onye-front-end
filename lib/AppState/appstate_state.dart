part of 'appstate_bloc.dart';

abstract class AppstateState extends Equatable {
  const AppstateState();
  
  @override
  List<Object> get props => [];
}

class AppstateInitial extends AppstateState {}


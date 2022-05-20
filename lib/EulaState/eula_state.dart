part of 'eula_bloc.dart';

abstract class EulaState extends Equatable {
  const EulaState();
  
  @override
  List<Object> get props => [];
}

class EulaInitial extends EulaState {


}

class EulaLoading extends EulaState {

  @override
  List<Object> get props => [];
}

class EulaLoaded extends EulaState {

  @override
  List<Object> get props => [];

}


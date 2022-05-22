part of 'eula_bloc.dart';

class EulaState extends Equatable {
  const EulaState({
  this.betaContract='', 
  this.isContractAccept=false});
  final String betaContract;
  final bool isContractAccept;



  @override
  List<Object> get props => [betaContract, isContractAccept];
}

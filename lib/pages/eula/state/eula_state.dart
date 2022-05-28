part of 'eula_bloc.dart';

enum FETCHINGCONTRACT { init, loading, failed, unknown, loaded }

enum ACCEPTCONTRACTSTATUS { init, inprogress, accept, failed, unkown }

class EulaState extends Equatable {
  const EulaState(
      {this.betaContract = '',
      this.isContractAccept = false,
      this.error='',
      this.acceptcontractstatus = ACCEPTCONTRACTSTATUS.init,
      this.fetchingcontract = FETCHINGCONTRACT.init});
  final String betaContract;
  final bool isContractAccept;
  final FETCHINGCONTRACT fetchingcontract;
  final String error;
  final ACCEPTCONTRACTSTATUS acceptcontractstatus;

  @override
  List<Object> get props => [betaContract, isContractAccept];

  EulaState copywith(
      {String? betaContract,
      bool? isContractAccept,
      String? error,
      FETCHINGCONTRACT? fetchingcontract,
      ACCEPTCONTRACTSTATUS? acceptcontractstatus}) {
    return EulaState(
      error: error??this.error,
        betaContract: betaContract ?? this.betaContract,
        fetchingcontract: fetchingcontract ?? this.fetchingcontract,
        acceptcontractstatus: acceptcontractstatus ?? this.acceptcontractstatus,
        isContractAccept: isContractAccept ?? this.isContractAccept);
  }
}

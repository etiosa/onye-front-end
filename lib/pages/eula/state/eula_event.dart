part of 'eula_bloc.dart';

abstract class EulaEvent extends Equatable {
  const EulaEvent();

  @override
  List<Object> get props => [];
}

class LoadBetaContract extends EulaEvent {
  //final String license;
  final String token;
  const LoadBetaContract({required this.token});
  @override
  List<Object> get props => [ token];
}

class LoadingBetaContract extends EulaEvent {}

class LoadingErrorBetaContract extends EulaEvent {
  final String error;
  const LoadingErrorBetaContract({required this.error});
  @override
  List<Object> get props => [error];
}

class LoadedContract extends EulaEvent {}

class LoadingUnknowError extends EulaEvent {
  final String error;
  const LoadingUnknowError(this.error);
  @override
  List<Object> get props => [error];
}

class AcceptContract extends EulaEvent {
  final String token;
  final String userId;
  const AcceptContract({required this.token, required this.userId});
  @override
  List<Object> get props => [token, userId];
}

class AccpetingBetaContract extends EulaEvent {}

class AcceptBetaFailed extends EulaEvent {
  final String error;

  const AcceptBetaFailed(this.error);
  @override
  List<Object> get props => [error];
}

class AccepBetaContractUnknownError extends EulaEvent {
  final String error;

  const AccepBetaContractUnknownError(this.error);
  @override
  List<Object> get props => [error];
}
class BetaContractAccept extends EulaEvent {}

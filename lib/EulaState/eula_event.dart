part of 'eula_bloc.dart';

abstract class EulaEvent extends Equatable {
  const EulaEvent();

  @override
  List<Object> get props => [];
}

class LoadBetaContract extends EulaEvent {
  final String license;
  final String token;
  const LoadBetaContract({required this.license, required this.token});
    @override
  List<Object> get props => [license, token];

}

class LoadingBetaContract extends EulaEvent {}

class LoadingErrorBetaContract extends EulaEvent {
  final String error;
  const LoadingErrorBetaContract({required this.error});
    @override
  List<Object> get props => [error];


}

class AcceptBetaContract extends EulaEvent {
  final String token;
  final String userId;
  const AcceptBetaContract({required this.token, required this.userId});
  @override
  List<Object> get props => [token, userId];
}

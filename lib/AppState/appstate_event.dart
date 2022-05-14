part of 'appstate_bloc.dart';

abstract class AppstateEvent extends Equatable {
  const AppstateEvent();

  @override
  List<Object> get props => [];
}

class CheckToken extends AppstateEvent {
  final String token;

  const CheckToken(this.token);
    @override
  List<Object> get props => [token];
  
}

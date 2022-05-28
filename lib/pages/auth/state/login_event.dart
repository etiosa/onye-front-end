part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInital extends LoginEvent {}

class LoginUserNameChanged extends LoginEvent {
  final String username;

  const LoginUserNameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => [password];
}

class LoginError extends LoginEvent {}

class LogOut extends LoginEvent {}

//data here
class Login extends LoginEvent {
  const Login();
}

//TODO:  implement this later
class LoginModalReset extends LoginEvent {}

/* class BetContract extends LoginEvent {
  final String token;
  const BetContract({required this.token});
   @override
  List<Object> get props => [token];
}
 */
/*   class AcceptBetaContract extends LoginEvent {
    final String token;
    final String userId;
    const AcceptBetaContract({required this.token, required this.userId});
    @override
    List<Object> get props => [token, userId];
  }
 */
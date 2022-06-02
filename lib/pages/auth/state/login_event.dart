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

class GetHome extends LoginEvent {
  String token;
  GetHome({required this.token});
}

//TODO:  implement this later
class LoginModalReset extends LoginEvent {}

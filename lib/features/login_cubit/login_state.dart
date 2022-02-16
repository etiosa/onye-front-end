part of 'login_cubit.dart';

enum LoginStatus { sucessful, failed, unknown, initial }

@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.userName = '',
      this.password = '',
      this.statusCode = 0,
      this.token='',
      this.loginStatus = false});

  final String userName;
  final String password;
  final int statusCode;
  final bool loginStatus;
  final String token;

  @override
  // TODO: implement props
  List<Object?> get props => [userName, password, statusCode, loginStatus, token];

  LoginState copywith(
      {String? userName,
      String? password,
      int? statusCode,
      String? token,
      bool? loginStatus}) {
    return LoginState(
      token: token ?? this.token,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

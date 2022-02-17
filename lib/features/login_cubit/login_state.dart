part of 'login_cubit.dart';

enum LoginStatus { sucessful, failed, unknown, initial }

@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.userName = '',
      this.password = '',
      this.statusCode = 0,
      this.loginToken = '',
      this.homeToken='',
      this.loginStatus = false});

  final String userName;
  final String password;
  final int statusCode;
  final bool loginStatus;
  final String homeToken;
  final String loginToken;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [userName, password, statusCode, loginStatus, homeToken, loginToken];

  LoginState copywith(
      {String? userName,
      String? password,
      int? statusCode,
      String? homeTokenS,
      String? loginToken,
      bool? loginStatus}) {
    return LoginState(
        homeToken: homeTokenS ?? homeToken,
        loginToken: loginToken ?? this.loginToken,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

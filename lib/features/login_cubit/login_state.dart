part of 'login_cubit.dart';

enum LoginStatus { sucessful, failed, unknown, initial }

@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.userName = '', this.password = '', this.statusCode = 0, this.loginStatus=false});

  final String userName;
  final String password;
  final int statusCode;
  final bool loginStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [userName, password,statusCode,loginStatus];

  LoginState copywith({String? userName, String? password, int? statusCode, bool? loginStatus}) {
    return LoginState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

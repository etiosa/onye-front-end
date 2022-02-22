part of 'login_cubit.dart';

enum LoginStatus { sucessful, failed, unknown, initial }

@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.userName = '',
      this.password = '',
      this.statusCode = 0,
      this.loginToken = '',
      this.homeToken = '',
      this.firstName = '',
      this.lastName = '',
      this.hospital = '',
      this.department='',
      this.loginStatus = false});

  final String userName;
  final String password;
  final int statusCode;
  final bool loginStatus;
  final String homeToken;
  final String firstName;
  final String lastName;
  final String department;
  final String hospital;
  final String loginToken;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [userName, password, statusCode, loginStatus, homeToken, loginToken, firstName,lastName, hospital, department];

  LoginState copywith(
      {String? userName,
      String? password,
      int? statusCode,
      String? homeTokenS,
      String? loginToken,
      String? firstName,
      String? lastName,
      String? department,
      String? hospital,
      bool? loginStatus}) {
    return LoginState(
        firstName: firstName?? this.firstName,
        lastName: lastName ?? this.lastName,
        department: department ?? this.department,
        hospital:  hospital ??this.hospital,
        homeToken: homeTokenS ?? homeToken,
        loginToken: loginToken ?? this.loginToken,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

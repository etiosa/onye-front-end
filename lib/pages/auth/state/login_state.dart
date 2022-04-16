part of 'login_cubit.dart';

enum LoginStatus { login, failed, unknown, logout, init }
enum LOGOUTSTATUS { sucessful, failed, unknown, init }

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
      this.department = '',
      this.id = '',
      this.role='',
      this.logoutstatus = LOGOUTSTATUS.init,
      this.loginStatus = LoginStatus.init});

  final String userName;
  final String password;
  final int statusCode;
  final String homeToken;
  final String firstName;
  final String lastName;
  final String department;
  final String hospital;
  final LOGOUTSTATUS logoutstatus;
  final String loginToken;
  final String id;
  final String role;
  final LoginStatus loginStatus;
  @override
  // TODO: implement props
  List<Object?> get props => [
        userName,
        password,
        statusCode,
        loginStatus,
        homeToken,
        loginToken,
        firstName,
        lastName,
        hospital,
        department,
        logoutstatus,
        id,
        role
      ];

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
      LOGOUTSTATUS? logoutstatus,
      String? id,
      String? role,
      LoginStatus? loginStatus}) {
    return LoginState(
      role: role ?? this.role,
        id: id ?? this.id,
        logoutstatus: logoutstatus ?? this.logoutstatus,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        department: department ?? this.department,
        hospital: hospital ?? this.hospital,
        homeToken: homeTokenS ?? homeToken,
        loginToken: loginToken ?? this.loginToken,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

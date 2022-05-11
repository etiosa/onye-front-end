part of 'login_bloc.dart';

enum LoginStatus { login, failed, unknown, logout, init, inprogress, home }
enum LOGOUTSTATUS { sucessful, failed, unknown, init }
enum FETCHINGCONTRACT { init, loading, failed, unknown, loaded }
enum ACCEPTCONTRACTSTATUS { init, inprogress, accept, failed, unkown }

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
      this.role = '',
      this.canLogin = false,
      this.inProgressModal = false,
      this.betaContract = '',
      this.isContractAccept = false,
      this.acceptcontractstatus = ACCEPTCONTRACTSTATUS.init,
      this.fetchContract = FETCHINGCONTRACT.init,
      this.logoutstatus = LOGOUTSTATUS.init,
      this.userId = '',
      this.specialty = '',
      this.currentDate=0,
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
  final bool inProgressModal;
  final LoginStatus loginStatus;
  final bool canLogin;
  final String betaContract;
  final bool isContractAccept;
  final FETCHINGCONTRACT fetchContract;
  final String userId;
  final String specialty;
  final ACCEPTCONTRACTSTATUS acceptcontractstatus;
  final int currentDate;
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
        role,
        inProgressModal,
        canLogin,
        betaContract,
        isContractAccept,
        fetchContract,
        acceptcontractstatus,
        userId,
        specialty,
        currentDate
      ];

  LoginState copywith(
      {String? userName,
      String? password,
      int? statusCode,
      String? userId,
      String? homeToken,
      String? loginToken,
      String? firstName,
      String? lastName,
      String? department,
      String? hospital,
      ACCEPTCONTRACTSTATUS? acceptcontractstatus,
      FETCHINGCONTRACT? fetchingcontract,
      String? betaContract,
      bool? isContractAccept,
      LOGOUTSTATUS? logoutstatus,
      String? id,
      bool? inProgressModal,
      String? role,
      String? specialty,
      bool? canLogin,
      int? currentDate,
      LoginStatus? loginStatus}) {
    return LoginState(
      currentDate: currentDate?? this.currentDate,
        specialty: specialty ?? this.specialty,
        userId: userId ?? this.userId,
        acceptcontractstatus: acceptcontractstatus ?? this.acceptcontractstatus,
        fetchContract: fetchingcontract ?? fetchContract,
        betaContract: betaContract ?? this.betaContract,
        isContractAccept: isContractAccept ?? this.isContractAccept,
        inProgressModal: inProgressModal ?? this.inProgressModal,
        role: role ?? this.role,
        id: id ?? this.id,
        canLogin: canLogin ?? this.canLogin,
        logoutstatus: logoutstatus ?? this.logoutstatus,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        department: department ?? this.department,
        hospital: hospital ?? this.hospital,
        homeToken: homeToken ?? this.homeToken,
        loginToken: loginToken ?? this.loginToken,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        statusCode: statusCode ?? this.statusCode);
  }
}

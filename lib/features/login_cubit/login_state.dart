part of 'login_cubit.dart';

@immutable
class LoginState extends Equatable {
  const LoginState({this.userName = '', this.password = ''});

  final String userName;
  final String password;

  @override
  // TODO: implement props
  List<Object?> get props => [userName, password];

  LoginState copywith({String? userName, String? password}) {
    return LoginState(
        userName: userName ?? this.userName,
        password: password ?? this.password);
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ignore: unused_field
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void setPassword(String? argpassword) {
    final String password = argpassword!;
    emit(state.copywith(password: password));
  }

  void setUserName(String? arguserName) {
    final String userName = arguserName!;
    emit(state.copywith(userName: userName));
  }

  void login() async {
    final String token = await _authRepository.signIn(
        username: state.userName, password: state.password);
    emit(state.copywith(loginToken: token));
    home(tokens: state.loginToken);
  }

  void home({String? tokens}) async {
    final body = await _authRepository.home(token: tokens);
    final String token = body['token'];
    print(body['userInfo']);
    emit(state.copywith(
        homeTokenS: token,
        firstName: body['userInfo']['firstName'],
        lastName: body['userInfo']['lastName'],
        hospital: body['userInfo']['facilityInfo']['name'],
        department: body['userInfo']['facilityInfo']['department']
      ));
  }
}
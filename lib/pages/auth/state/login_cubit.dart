import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/session/authSession.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ignore: unused_field
  final AuthRepository _authRepository;
  final _authSession = AuthSession();

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
    home(homeToken: state.loginToken);
  }

  void home({String? homeToken}) async {
    final body = await _authRepository.home(token: homeToken);
    final String token = body['token'];
    print(body);
    emit(state.copywith(
        homeTokenS: token,
        firstName: body['userInfo']['firstName'],
        lastName: body['userInfo']['lastName'],
        hospital: body['userInfo']['facilityInfo']['name'],
        department: body['userInfo']['facilityInfo']['department']));
    print(state);
    _authSession.saveHomeToken(homeToken: token).then((value) => emit(
        state.copywith(
            loginStatus: LoginStatus.login, logoutstatus: LOGOUTSTATUS.init)));
    //saved the profile information here
  }

  void logout({String? token}) async {
    final homeToken = await _authSession.getHomeToken();

    final response = await _authRepository.signout(token: homeToken);

    final logout = await _authSession.removeHomeToken();
    if (logout) {
      emit(state.copywith(
          loginStatus: LoginStatus.logout,
          logoutstatus: LOGOUTSTATUS.sucessful));
    } else {
      emit(state.copywith(
          loginStatus: LoginStatus.logout,
          logoutstatus: LOGOUTSTATUS.sucessful));
    }
  }
}

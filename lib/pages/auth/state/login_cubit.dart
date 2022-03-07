import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/session/authSession.dart';
import "package:http/http.dart" as http;

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

//TODO: move this to model class later
  void login() async {
    final http.Response? response = await _authRepository.signIn(
        username: state.userName, password: state.password);
    final body = jsonDecode(response!.body);
    final token = body['token'];
    print(token);
    final statusCode = response.statusCode;
    emit(state.copywith(loginToken: token, statusCode: statusCode));
    home(homeToken: state.loginToken);
  }

  void home({String? homeToken}) async {
    final http.Response? response =
        await _authRepository.home(token: homeToken);
   
    final body =  jsonDecode(response!.body);
    final statusCode =response.statusCode;
    final token = body['token'];


    setLoginData(token, body);
    _authSession.saveHomeToken(homeToken: token).then((value) => emit(
      state.copywith(
        statusCode: statusCode,
              loginStatus: LoginStatus.login,
              logoutstatus: LOGOUTSTATUS.init))); 
  }

  void setLoginData(String token, body) {
    return emit(state.copywith(
        homeTokenS: token,
        firstName: body['userInfo']['firstName'],
        lastName: body['userInfo']['lastName'],
        hospital: body['userInfo']['facilityInfo']['name'],
        id: body['userInfo']['id'],
        department: body['userInfo']['facilityInfo']['department']));
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

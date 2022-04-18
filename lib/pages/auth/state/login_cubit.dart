import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/components/clinicalNote/clinicalnote_cubit.dart';
import 'package:onye_front_ened/components/repository/clinical_note_repository.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/pages/registration/repository/registration_repository.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';
import "package:http/http.dart" as http;

import '../../patient/repository/patientRepository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ignore: unused_field
  final AuthRepository _authRepository;
  final PatientRepositories _registerRepository = PatientRepositories();
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final RegistrationRepository _registrationRepository =
      RegistrationRepository();
  final ClinicalNoteRepository _clinicalNoteRepository =
      ClinicalNoteRepository();
  final PatientRepositories _registrationRepositories = PatientRepositories();

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
    final statusCode = response.statusCode;
    emit(state.copywith(loginToken: token, statusCode: statusCode));
    home(homeToken: state.loginToken);
  }

  void home({String? homeToken}) async {
    final http.Response? response =
        await _authRepository.home(token: homeToken);

    final body = jsonDecode(response!.body);
    final statusCode = response.statusCode;
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
        role: body['userInfo']['type'],
        department: body['userInfo']['facilityInfo']['department']));
  }

  void logout({String? token}) async {
    final homeToken = await _authSession.getHomeToken();

    final RegisterationCubit _regubit =
        RegisterationCubit(_registrationRepository);
    final AppointmentCubit _appCubit = AppointmentCubit(_appointmentRepository);
    final ClinicalnoteCubit _clinCubit =
        ClinicalnoteCubit(_clinicalNoteRepository);
    // ignore: non_constant_identifier_names
    final PatientCubit _aptCubit = PatientCubit(_registrationRepositories);

  

    final response = await _authRepository.signout(token: homeToken);

    final logout = await _authSession.removeHomeToken();
    if (logout) {
      //clear all the state
      _appCubit.clearState();
      _regubit.clearState();
      _clinCubit.clearState();
      _aptCubit.clearState();
      clearState();
      emit(state.copywith(
          loginStatus: LoginStatus.logout,
          logoutstatus: LOGOUTSTATUS.sucessful));
    }
    print("Unable to logout");
  }

  void clearState() {
    emit(const LoginState());
  }
}

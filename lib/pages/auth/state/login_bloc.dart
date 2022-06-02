import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/components/clinicalNote/clinical_note_cubit.dart';
import 'package:onye_front_ened/components/repository/clinical_note_repository.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/pages/registration/repository/registration_repository.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';
import "package:http/http.dart" as http;
import 'package:onye_front_ened/system/analytics/auth_analytics.dart';

import '../../patient/repository/patient_repository.dart';

part 'login_state.dart';
part "login_event.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // ignore: unused_field
  final AuthRepository _authRepository;
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final RegistrationRepository _registrationRepository =
      RegistrationRepository();
  final ClinicalNoteRepository _clinicalNoteRepository =
      ClinicalNoteRepository();
  final PatientRepositories _registrationRepositories = PatientRepositories();
  final AuthAnalytics _authAnalytics = AuthAnalytics();

  final _authSession = AuthSession();

  LoginBloc(this._authRepository) : super(const LoginState()) {
    on<LoginPasswordChanged>(_onPasswordChanged); //on map the event
    on<LoginUserNameChanged>(_onUserNameChanged);
    on<Login>(_login);
    on<LogOut>(_logout);
    on<LoginModalReset>(_resetModal);
    on<GetHome>(_getHome);
  }

  void _resetModal(
    LoginModalReset event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copywith(inProgressModal: false));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = event.password;
    emit(state.copywith(password: password));
  }

  void _onUserNameChanged(
      LoginUserNameChanged event, Emitter<LoginState> emit) {
    final username = event.username;

    emit(state.copywith(userName: username));
  }

/* TODO: CHANGED to userModal*/
  void _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copywith(
        loginStatus: LoginStatus.inprogress, inProgressModal: true));

    try {
      final http.Response? response = await _authRepository.signIn(
          username: state.userName, password: state.password);
      final body = jsonDecode(response!.body);
      final sucess = body['success'];
      //final statusCode = response.statusCode;
      emit(state.copywith(canLogin: sucess));
      if (sucess) {
        final token = body['token'];
        emit(state.copywith(
            loginStatus: LoginStatus.login,
            loginToken: token,
            inProgressModal: false));
        home(homeToken: state.loginToken);
      } else {
        emit(state.copywith(
            loginStatus: LoginStatus.failed, inProgressModal: false));
      }
    } catch (err) {
      emit(state.copywith(
          loginStatus: LoginStatus.unknown, inProgressModal: false));
    }
  }

  Future<Response> home({String? homeToken}) async {
    final http.Response? response =
        await _authRepository.home(token: homeToken);
    final body = jsonDecode(response!.body);
    final statusCode = response.statusCode;
    final token = body['token'];

    if (statusCode == 200) {
      setLoginData(token, body);
      emit(state.copywith(
        loginStatus: LoginStatus.home,
        homeToken: token,
      ));

      _authSession.saveHomeToken(homeToken: token).then((value) => emit(
          state.copywith(
              statusCode: statusCode,
              loginStatus: LoginStatus.login,
              logoutstatus: LOGOUTSTATUS.init)));
    } else {
      emit(state.copywith(statusCode: statusCode));
    }
    return response;
  }

//TODO: implementation latger
  void _getHome(GetHome event, Emitter<LoginState> emit) {
    emit(state.copywith(
      loginStatus: LoginStatus.home,
      homeToken: event.token,
    ));
  }

  void setCurrentDate() {
    emit(state.copywith(currentDate: DateTime.now().hour));
  }

  void setLoginData(String token, body) {
    _authAnalytics.login(
        authMethod: 'email/password',
        authState: state.loginStatus.toString() + "_" + "200",
        userId: body['userInfo']['id']);

    _authAnalytics.setUserLog(
        firstName: body['userInfo']['firstName'],
        lastName: body['userInfo']['lastName'],
        hospital: body['userInfo']['facilityInfo']['name'],
        hospitalId: body['userInfo']['facilityInfo']['facilityId'],
        userType: body['userInfo']['type']);

    return emit(state.copywith(
        firstName: body['userInfo']['firstName'],
        lastName: body['userInfo']['lastName'],
        hospital: body['userInfo']['facilityInfo']['name'],
        id: body['userInfo']['id'],
        isContractAccept: body['userInfo']['acceptedEula'],
        userId: body['userInfo']['userId'],
        specialty: body['userInfo']['specialty'],
        role: body['userInfo']['type'],
        currentDate: DateTime.now().hour,
        department: body['userInfo']['facilityInfo']['department']));
  }

  void _logout(LogOut event, Emitter<LoginState> emit) async {
    final homeToken = await _authSession.getHomeToken();

    final RegisterationCubit _regubit =
        RegisterationCubit(_registrationRepository);
    final AppointmentCubit _appCubit = AppointmentCubit(_appointmentRepository);
    final ClinicalnoteCubit _clinCubit =
        ClinicalnoteCubit(_clinicalNoteRepository);
    // ignore: non_constant_identifier_names
    final PatientCubit _aptCubit = PatientCubit(_registrationRepositories);

    //final response = await _authRepository.signout(token: homeToken);

    final logout = await _authSession.removeHomeToken();
    if (logout) {
      _authAnalytics.logout(
          authState: state.logoutstatus.toString() + "_" + "12",
          userId: state.userId,
          authMethod: 'email/password');

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
  }

  void clearState() {
    emit(const LoginState());
  }
}

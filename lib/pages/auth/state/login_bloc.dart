import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
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
part "login_event.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
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

  LoginBloc(this._authRepository) : super(const LoginState()) {
    on<LoginPasswordChanged>(_onPasswordChanged); //on map the event
    on<LoginUserNameChanged>(_onUserNameChanged);
    on<Login>(_login);
    on<LogOut>(_logout);
    on<LoginModalReset>(_resetModal);
    on<BetContract>(_setContract);
    on<AcceptBetaContract>(_acceptBetaContract);
  }

  void _setContract(BetContract event, Emitter<LoginState> emit) async {
    emit(state.copywith(fetchingcontract: FETCHINGCONTRACT.loading));
    try {
      var licenseResponse =
          await _authRepository.getLicenseAgreement(token: event.token);
      final body = jsonDecode(licenseResponse!.body);
      final license = body['licenseAgreement'];
      final statusCode = licenseResponse.statusCode;
      if (statusCode != 200) {
        emit(state.copywith(fetchingcontract: FETCHINGCONTRACT.failed));
      } else {
        emit(state.copywith(
            fetchingcontract: FETCHINGCONTRACT.loaded, betaContract: license));
      }
    } catch (err) {
      emit(state.copywith(fetchingcontract: FETCHINGCONTRACT.unknown));
    }
  }

  void _acceptBetaContract(
      AcceptBetaContract event, Emitter<LoginState> emit) async {
    emit(state.copywith(acceptcontractstatus: ACCEPTCONTRACTSTATUS.inprogress));

    try {
      var acceptContractResponse = await _authRepository.acceptContract(
          token: event.token, userId: event.userId);

      final statsCode = acceptContractResponse?.statusCode;
      if (statsCode == 204) {
        emit(state.copywith(
            acceptcontractstatus: ACCEPTCONTRACTSTATUS.accept,
            isContractAccept: true));
      } else {
        emit(state.copywith(acceptcontractstatus: ACCEPTCONTRACTSTATUS.failed));
      }
    } catch (err) {
      emit(state.copywith(acceptcontractstatus: ACCEPTCONTRACTSTATUS.unkown));
    }
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
      final statusCode = response.statusCode;
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
      //authsession is done in background
      //so I can emit the state here  if its 200
      //we have login
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

  void setCurrentDate() {
    emit(state.copywith(currentDate: DateTime.now().hour));
  }

  void setLoginData(String token, body) {
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
    } else {
    }
  }

  void clearState() {
    emit(const LoginState());
  }
}

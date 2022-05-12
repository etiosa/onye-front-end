import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:onye_front_ened/pages/registration/repository/registration_repository.dart';

part 'registration_state.dart';

class RegisterationCubit extends Cubit<RegistrationState> {
  RegisterationCubit(this._registrationRepository)
      : super(const RegistrationState());
  final RegistrationRepository _registrationRepository;

  Future<Response?> createRegistration(
      {String? token,
      String? patientID,
      String? appointmentId,
      String? reasons,
      String? typeOfVisit}) async {
    //
    emit(state.copyWith(registerState: REGISTRATIONSTATE.inprogress));
    Response? req = await _registrationRepository.createRegistration(
        token: token,
        patientId: patientID,
        appointmentId: appointmentId,
        reasons: reasons,
        typeOfVisit: typeOfVisit);

    //handle error here
    var body = json.decode(req!.body);
    var type = body['type'];
    print(type);

    if (req.statusCode != 201) {
      emit(state.copyWith(
          registrationError: body['message'],
          registerState: REGISTRATIONSTATE.failed));
    } else {
      emit(state.copyWith(
          registerState: REGISTRATIONSTATE.sucessful, type: body['type']));
    }

    //Update the state after the register..we get back a payload from the API
    //searchRegistrations(token: token);

    return req;
  }

  void setRegistrationDate(String? registrationDate) {
    emit(state.copyWith(registrationStartDate: registrationDate!));
  }

  void setRegistrationTime(String? registrationTime) {
    print("setRegistrationTime(");
    emit(state.copyWith(registrationStartTime: registrationTime!));
  }

  void setRegistrationEndTime(String? registrationTime) {
    emit(state.copyWith(registrationEndTime: registrationTime!));
  }

  void setRegistrationEndDate(String? registrationDate) {
    emit(state.copyWith(registrationEndDate: registrationDate!));
  }

  void setRegisterState() {
    emit(state.copyWith(registerState: REGISTRATIONSTATE.init));
  }

  void setRegistrationError({String? registrationError}) {
    emit(state.copyWith(registrationError: registrationError));
  }

  void searchRegistrations(
      {String? token,
      String? searchParams,
      int? nextPage,
      String? startDateTime,
      String? endDateTime}) async {

        
    emit(state.copyWith(searchState: SEARCHSTATE.inital));
    emit(state.copyWith(
        regLoad: REGISTERSTATELOAD.loading,
        registrationEndDate: '',
        registrationEndTime: '',
        registrationStartTime: '',
        registrationStartDate: ''));

    var searchReponse = await _registrationRepository.searchRegistrations(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        token: token,
        searchParams: searchParams);

    var body = json.decode(searchReponse!.body);
    var registrationsList = body['elements'];
    var totalPages = body['totalPages'];
    emit(state.copyWith(
        registrationList: registrationsList, maxPageNumber: totalPages, ));

    if (state.registrationList.isEmpty) {
      emit(state.copyWith(searchState: SEARCHSTATE.notFound));
      emit(state.copyWith(regLoad: REGISTERSTATELOAD.failed));
    } else {
      emit(state.copyWith(searchState: SEARCHSTATE.sucessful));
      emit(state.copyWith(regLoad: REGISTERSTATELOAD.loaded));
    }
  }

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;

    emit(state.copyWith(searchParams: searchParams));
  }

  void searchPatients({String? query, String? token, int? nextPage}) async {
    var searchResponse = await _registrationRepository.searchPatients(
        searchParams: query, token: token, nextPage: 0);
    var body = json.decode(searchResponse!.body);
    var totalPages = body['totalPages'];
    var patientsList = body['elements'];
    emit(state.copyWith(
        patientList: patientsList, maxPatientPageNumber: totalPages));
  }

  void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(
        state.copyWith(nextPage: nextPage, regLoad: REGISTERSTATELOAD.loading));
    if (state.nextPage <= state.maxPageNumber) {
      //call search
      var searchResponse = await _registrationRepository.searchRegistrations(
          token: token, searchParams: searchParams, nextPage: state.nextPage);
      var body = json.decode(searchResponse!.body);
      var registrationsList = body['elements'];
      emit(state.copyWith(registrationList: registrationsList));
      if (state.registrationList.isNotEmpty) {
        emit(state.copyWith(regLoad: REGISTERSTATELOAD.loaded));
      }
    }
  }

  void setTypeOfVisit(String? argTypeOfVisit) {
    final String typeofVisit = argTypeOfVisit!;
    emit(state.copyWith(typeOfVisit: typeofVisit));
  }

  void setReasonForVisit(String? argReasonForVisit) {
    final String reasonForVisit = argReasonForVisit!;
    emit(state.copyWith(reasonForVisit: reasonForVisit));
  }

  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedMedicalPersonnelId: selectedId));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedPatientId: selectedId));
  }

  void clearState() {
    emit(const RegistrationState());
  }
}

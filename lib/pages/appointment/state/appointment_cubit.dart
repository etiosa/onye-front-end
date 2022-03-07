import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository _appointmentRepository;

  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments({String? token, String? searchParams}) async {
    emit(state.copyWith(searchState: SEARCHSTATE.inital));

    var appointments = await _appointmentRepository.searchAppointments(
        token: token, searchParams: state.searchParams);
    emit(state.copyWith(appointmentList: appointments));
    if (state.appointmentList.isEmpty) {
      emit(state.copyWith(searchState: SEARCHSTATE.notFound));
    } else {
      emit(state.copyWith(searchState: SEARCHSTATE.sucessful));
    }
  }

  //TODO: separate this method

  void searchPatients({String? query, String? token}) async {
    var patients = await _appointmentRepository.searchPatients(
        searchParams: query, token: token);
    emit(state.copyWith(patientsList: patients));
  }

  void searchDoctors({String? query, String? token}) async {
    emit(state.copyWith(searchState: SEARCHSTATE.startsearch));
    var doctors = await _appointmentRepository.searchDoctors(
        searchParams: query, token: token);
    if (doctors.isNotEmpty) {
      emit(state.copyWith(
          doctorsList: doctors, searchState: SEARCHSTATE.sucessful));
    }
    if (doctors.isEmpty) {
      emit(state.copyWith(
          doctorsList: doctors, searchState: SEARCHSTATE.notFound));
    }
  }

  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedMedicalPersonnelId: selectedId));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedPatientId: selectedId));
  }

  void setAppointmentId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedAppointmentId: selectedId));
  }

  void setTypeOfVisit(String? argTypeOfVisit) {
    final String typeofVisit = argTypeOfVisit!;
    emit(state.copyWith(typeOfVisit: typeofVisit));
  }

  void setReasonForVisit(String? argReasonForVisit) {
    final String reasonForVisit = argReasonForVisit!;
    emit(state.copyWith(reasonForVisit: reasonForVisit));
  }

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;

    emit(state.copyWith(searchParams: searchParams));
  }

  void setStartTime(String? argStartTime) {
    final String startTime = argStartTime!;
    emit(state.copyWith(startTime: startTime));
  }

  void setEndTime(String? argEndTime) {
    final String endTime = argEndTime!;
    emit(state.copyWith(endTime: endTime));
  }

  void setStartDate(String? argStartDate) {
    final String startDate = argStartDate!;
    emit(state.copyWith(startDate: startDate));
  }

  void setSelectedMedicalIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;
    emit(state.copyWith(selectedMedicalIndex: selectedIndex));
  }

  void setSelectedPatientIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;

    emit(state.copyWith(selectedPatientIndex: selectedIndex));
  }

  void setClinicalNote(String? note) {
    final String clinicalNote = note!;
    emit(state.copyWith(clinicalNote: clinicalNote));
  }

  void setClinicalNoteTitle(String? title) {
    final String clinicalNoteTitle = title!;
    emit(state.copyWith(clinicalNoteTitle: clinicalNoteTitle));
  }

  void setClinicalNoteType(String? type) {
    final String clinicalNoteType = type!;
    emit(state.copyWith(clinicalNoteType: clinicalNoteType));
  }

  Future<Response?> createClinicalNote(
      {String? token,
      String? patientId,
      String? medicalId,
      String? title,
      String? note,
      String? registerationId,
      String? clinicalNoteType}) async {
    Response? req = await _appointmentRepository.createClinicalNote(
        token: token,
        patientId: patientId,
        medicalId: medicalId,
        note: note,
        registerationId: registerationId,
        clincialNoteType: clinicalNoteType,
        title: title);

    return req;
  }

  Future<Response?> createRegistration(
      {String? token,
      String? patientID,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? typeOfVisit}) async {
    Response? req = await _appointmentRepository.createRegistration(
        token: token,
        patientId: patientID,
        medicalId: medicalId,
        appointmentId: appointmentId,
        reasons: reasons,
        typeOfVisit: typeOfVisit);
    print(token);
    searchRegistrations(token: token);

    return req;
  }

  Future<Response?> getPatientClinicalNote({
    String? token,
    String? id,
  }) async {
    Response? req = await _appointmentRepository.getPatientClinicalNote(
        token: token, id: id);
    setPatientClinicalNote(req!);
    return req;
  }

  void setPatientClinicalNote(Response req) async {
    final body = jsonDecode(req.body);

    emit(state.copyWith(
        clinicalNote: body['text'],
        clinicalNoteTitle: body['title'],
        clinicalNoteType: body['type']));
  }

  void searchRegistrations({String? token, String? searchParams}) async {
    emit(state.copyWith(searchState: SEARCHSTATE.inital));
    var registrationsList = await _appointmentRepository.searchRegistrations(
        token: token, searchParams: searchParams);
    emit(state.copyWith(registrationList: registrationsList));

    if (state.registrationList.isEmpty) {
      emit(state.copyWith(searchState: SEARCHSTATE.notFound));
    } else {
      emit(state.copyWith(searchState: SEARCHSTATE.sucessful));
    }
  }

  Future<Response?> createAppointment(
      {String? appointmentDateTime,
      String? patientID,
      String? medicalId,
      String? token,
      int? minDuration,
      String? typeOfVisit,
      String? reasonForVisit,
      String? date,
      String? time,
      String? languagePreference}) async {
    var dateTime =
        DateFormat('yyyy-MM-dd h:mm aa').parse(date! + " " + time!, true);

    Response? req = await _appointmentRepository.createAppointment(
        date: dateTime.toIso8601String(),
        patientId: patientID,
        medicalId: medicalId,
        token: token,
        typeOfVisit: typeOfVisit,
        reasons: reasonForVisit);

    return req;
  }

  Future<Response?> updateClinicalNote({
    String? id,
    String? type,
    String? title,
    String? noteText,
    String? token,
  }) async {
    Response? response = await _appointmentRepository.updateClinicalNote(
      id: id,
      type: type,
      noteText: noteText,
      title: title,
      token: token,
    );

    return response;
  }

  Future<Response?> updateAppointment({
    String? id,
    String? date,
    String? time,
    String? languagePreference,
    String? typeOfVisit,
    String? reasonForVisit,
    String? token,
  }) async {
    var dateTime =
        DateFormat('yyyy-MM-dd h:mm aa').parse(date! + " " + time!, true);
    Response? response = await _appointmentRepository.updateAppointment(
      id: id,
      languagePreference: languagePreference,
      typeOfVisit: typeOfVisit,
      reasonForVisit: reasonForVisit,
      appointmentDateTime: dateTime.toIso8601String(),
      token: token,
    );

    return response;
  }

  Future<Response?> cancelAppointment({
    String? id,
    String? token,
  }) async {
    Response? response = await _appointmentRepository.cancelAppointment(
      id: id,
      token: token,
    );

    return response;
  }

  void clearState() {
    emit(const AppointmentState());
  }
}

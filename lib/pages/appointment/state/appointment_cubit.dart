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

  void searchPatients({String? query, String? token, int? nextPage}) async {
    var searchResponse = await _appointmentRepository.searchPatients(
        searchParams: query, token: token);
    var body = json.decode(searchResponse!.body);
    var totalPages = body['totalPages'];

    var patientsList = body['elements'];
    emit(state.copyWith(patientsList: patientsList, maxPageNumber: totalPages));
  }

  void setPatientNextSearchIndex(
      {int? nextPage, String? token, String? searchParams}) async {
    if (state.nextPage <= state.maxPageNumber) {
      var searchReponse = await _appointmentRepository.searchPatients(
          searchParams: searchParams, token: token, nextPage: nextPage);

      var body = json.decode(searchReponse!.body);
      var patientsList = body['elements'];
      emit(state.copyWith(patientsList: patientsList));
    }
  }

/*   void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(state.copyWith(nextPage: nextPage));
    if (state.nextPage <= state.maxPageNumber) {
      //call search
      var searchReponse = await _appointmentRepository.searchRegistrations(
          token: token, searchParams: searchParams, nextPage: state.nextPage);
      var body = json.decode(searchReponse!.body);
          var registrationsList = body['elements'];
emit(state.copyWith(
          registrationList: registrationsList));
    }
  }
*/

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

  void setAppointmentTime(String? argAppointmentTime) {
    final String appointmentTime = argAppointmentTime!;
    emit(state.copyWith(appointmentTime: appointmentTime));
  }

  void setAppointmentDate(String? argAppointmentDate) {
    final String appointmentDate = argAppointmentDate!;
    emit(state.copyWith(appointmentDate: appointmentDate));
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
      String? registrationId,
      String? clinicalNoteType}) async {
    Response? req = await _appointmentRepository.createClinicalNote(
        token: token,
        patientId: patientId,
        medicalId: medicalId,
        note: note,
        registerationId: registrationId,
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

  void setclinicalNoteID(String clinicalNoteId) {
    emit(state.copyWith(clinicalNoteID: clinicalNoteId));
  }

  void searchRegistrations(
      {String? token, String? searchParams, int? nextPage}) async {
    emit(state.copyWith(searchState: SEARCHSTATE.inital));
    var searchReponse = await _appointmentRepository.searchRegistrations(
        token: token, searchParams: searchParams);

    var body = json.decode(searchReponse!.body);
    var registrationsList = body['elements'];
    var totalPages = body['totalPages'];
    emit(state.copyWith(
        registrationList: registrationsList, maxPageNumber: totalPages));

    if (state.registrationList.isEmpty) {
      emit(state.copyWith(searchState: SEARCHSTATE.notFound));
    } else {
      emit(state.copyWith(searchState: SEARCHSTATE.sucessful));
    }
  }

  void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(state.copyWith(nextPage: nextPage));
    if (state.nextPage <= state.maxPageNumber) {
      //call search
      var searchResponse = await _appointmentRepository.searchRegistrations(
          token: token, searchParams: searchParams, nextPage: state.nextPage);
      var body = json.decode(searchResponse!.body);
      var registrationsList = body['elements'];
      emit(state.copyWith(registrationList: registrationsList));
    }
  }

  Future<Response?> createAppointment(
      {String? dateTime,
      String? patientID,
      String? medicalId,
      String? token,
      int? minDuration,
      String? typeOfVisit,
      String? reasonForVisit,
      String? date,
      String? time,
      String? languagePreference}) async {
    var dateAndTime =
        DateFormat('yyyy-MM-dd h:mm aa').parse(date! + " " + time!, true);

    Response? req = await _appointmentRepository.createAppointment(
        date: dateAndTime.toIso8601String(),
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
    print(token);
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
      dateTime: dateTime.toIso8601String(),
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

//TODO: move this to a different class
  void clearClinicalNoteState() {
    emit(state.copyWith(
        clinicalNote: '',
        clinicalNoteID: '',
        clinicalNoteTitle: ''));
  }
}

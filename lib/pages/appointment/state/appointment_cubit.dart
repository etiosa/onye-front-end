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

  Future<void> searchAppointments({String? token, String? searchParams, String? startDateTime,
      String? endDateTime
  }) async {
    emit(state.copyWith(
        searchState: REGSEARCHSTATE.inital,
        appointmentloadState: APPOINTMENTLOADSTATE.loading));

    var appointmentsReponse = await _appointmentRepository.searchAppointments(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
        token: token, searchParams: state.searchParams);
    var appointmentReponseBody = json.decode(appointmentsReponse!.body);
    var appointmentList = appointmentReponseBody['elements'];
    var totalPages = appointmentReponseBody['totalPages'];

    emit(state.copyWith(
        appointmentList: appointmentList, maxPageNumber: totalPages));
    if (state.appointmentList.isEmpty) {
      emit(state.copyWith(searchState: REGSEARCHSTATE.notFound));
      emit(state.copyWith(appointmentloadState: APPOINTMENTLOADSTATE.failed));
    } else {
      // print(state.maxPageNumber);
      emit(state.copyWith(
          searchState: REGSEARCHSTATE.sucessful,
          appointmentloadState: APPOINTMENTLOADSTATE.loaded));
    }
  }

  //TODO: separate this method

/*   void searchPatients({String? query, String? token, int? nextPage}) async {
    var searchResponse = await _appointmentRepository.searchPatients(
        searchParams: query, token: token);
    var body = json.decode(searchResponse!.body);
    var totalPages = body['totalPages'];

    var patientsList = body['elements'];
    emit(state.copyWith(patientsList: patientsList, maxPageNumber: totalPages));
  }
 */
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

  void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(state.copyWith(
        nextPage: nextPage,
        appointmentloadState: APPOINTMENTLOADSTATE.loading));
    if (state.nextPage <= state.maxPageNumber) {
      //call search
      var searchResponse = await _appointmentRepository.searchAppointments(
          token: token, searchParams: searchParams, nextPage: state.nextPage);
      var body = json.decode(searchResponse!.body);
      var appointmentList = body['elements'];
      emit(state.copyWith(appointmentList: appointmentList));
      if (state.appointmentList.isNotEmpty) {
        emit(state.copyWith(appointmentloadState: APPOINTMENTLOADSTATE.loaded));
      }
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
    //deal with empty string
    emit(state.copyWith(appointmentstate: APPOINTMENTSTATE.inprogress));
    Response? req = await _appointmentRepository.createAppointment(
        date: dateAndTime.toIso8601String(),
        patientId: patientID,
        medicalId: medicalId,
        token: token,
        typeOfVisit: typeOfVisit,
        reasons: reasonForVisit);

    var body = json.decode(req!.body);

    if (req.statusCode != 201) {
      emit(state.copyWith(
          appointmentstate: APPOINTMENTSTATE.failed,
          appointmenterror: body['message']));
    } else {
      emit(state.copyWith(appointmentstate: APPOINTMENTSTATE.sucessful));
    }

    return req;
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

  void setFromDate(String? argFromDate) {
    final String fromDate = argFromDate!;
    emit(state.copyWith(fromDate: fromDate));
  }

  void setAppointmentState() {
    emit(state.copyWith(appointmentstate: APPOINTMENTSTATE.inita));
  }

  String getFromDate() {
    return state.fromDate;
  }

  void setFromTime(String? argFromTime) {
    final String fromTime = argFromTime!;
    emit(state.copyWith(fromTime: fromTime));
  }

  String getFromTime() {
    return state.fromTime;
  }

  void setToDate(String? argToDate) {
    final String toDate = argToDate!;
    emit(state.copyWith(toDate: toDate));
  }

  String getToDate() {
    return state.toDate;
  }

  void setToTime(String? argToTime) {
    final String toTime = argToTime!;
    emit(state.copyWith(toTime: toTime));
  }

  String getToTime() {
    return state.toTime;
  }

  void clearState() {
    emit(const AppointmentState());
  }

  void clearAppointmentField() {
    emit(state.copyWith(
      typeOfVisit: '',
      reasonForVisit: '',
      appointmentTime: '',
    ));
  }
}

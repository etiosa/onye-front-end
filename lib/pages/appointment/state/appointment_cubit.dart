import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository _appointmentRepository;

  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments({String? token, String? searchParams}) async {
    emit(state.copyWith(searchstate: SEARCHSTATE.inital));

    var appointments = await _appointmentRepository.searchAppointments(
        token: token, searchParams: state.searchParams);
    emit(state.copyWith(appointmentList: appointments));
    if (state.appointmentList.isEmpty) {
      emit(state.copyWith(searchstate: SEARCHSTATE.notFound));
    } else {
      emit(state.copyWith(searchstate: SEARCHSTATE.sucessful));
    }
  }

  void searchPatients({String? query, String? token}) async {
    var patients = await _appointmentRepository.searchPatients(
        searchParams: query, token: token);
    emit(state.copyWith(patientsList: patients));
  }

  void searchDoctors({String? query, String? token}) async {
    emit(state.copyWith(searchstate: SEARCHSTATE.startsearch));
    var doctors = await _appointmentRepository.searchDoctors(
        searchParams: query, token: token);
    if (doctors.isNotEmpty) {
      emit(state.copyWith(
          doctorsList: doctors, searchstate: SEARCHSTATE.sucessful));
    }
    if (doctors.isEmpty) {
      emit(state.copyWith(
          doctorsList: doctors, searchstate: SEARCHSTATE.notFound));
    }
  }

  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedMedicalPersonnel: selectedId));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedPatientId: selectedId));
  }

  void setAppointmentId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedAppointmentId: selectedId));
  }

  void setTypeOfVisit(String? argtypeOfVisit) {
    final String typeofVisit = argtypeOfVisit!;
    emit(state.copyWith(typeOfVisit: typeofVisit));
  }

  void setReasonForVisit(String? argresonsforvist) {
    final String resonsForVisiit = argresonsforvist!;
    emit(state.copyWith(reasonForVisit: resonsForVisiit));
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

  void setEndDate(String? argEndDate) {
    final String endDate = argEndDate!;

    emit(state.copyWith(endDate: endDate));
  }

  void setDatTimeDateFormat() {}

  void setSelectedMedicalIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;
    emit(state.copyWith(selectedMedicalIndex: selectedIndex));
  }

  void setSelectedPatientIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;

    emit(state.copyWith(selectedPatientIndex: selectedIndex));
  }

  void setClincialNote(String? note) {
    final String clinicalNote = note!;
    emit(state.copyWith(clinicalNote: clinicalNote));
  }

  void setClinicialNoteTitle(String? title) {
    final String clincialTitle = title!;
    emit(state.copyWith(clinicalNoteTitle: clincialTitle));
  }

  void setClinicalNoteType(String? type) {
    final String cliniclaType = type!;
    emit(state.copyWith(clinicalNoteType: cliniclaType));
  }

  Future<Response?> createClinicalNote(
      {String? token,
      String? patientId,
      String? medicalId,
      String? title,
      String? note,
      String? clincialNoteType}) async {
    Response? req = await _appointmentRepository.createClinicalNote(
        token: token,
        patientId: patientId,
        medicalId: medicalId,
        note: note,
        clincialNoteType: clincialNoteType,
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

  void searchRegistrations({String? token, String? searchParams}) async {
    emit(state.copyWith(searchstate: SEARCHSTATE.inital));
    var registrationsList = await _appointmentRepository.searchRegistrations(
        token: token, searchParams: searchParams);
    emit(state.copyWith(registerationList: registrationsList));

    if (state.registrationList.isEmpty) {
      emit(state.copyWith(searchstate: SEARCHSTATE.notFound));
    } else {
      emit(state.copyWith(searchstate: SEARCHSTATE.sucessful));
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
    var inputFormat = DateFormat('yyyy-dd-MM hh:mm a');
    var dateTime = inputFormat.parse(date! + ' ' + time!, true);

    Response? req = await _appointmentRepository.createAppointment(
        date: dateTime.toIso8601String(),
        patientId: patientID,
        medicalId: medicalId,
        token: token,
        typeOfVisit: typeOfVisit,
        reasons: reasonForVisit);

    return req;
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
}

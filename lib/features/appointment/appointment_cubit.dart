import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:onye_front_ened/repositories/appointment_repositories/appointment_repositories.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository _appointmentRepository;
  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments({String? token}) async {
    final String startDateTime = state.startDate + ' ' + state.startTime;
    final String endDateTime = state.endDate + ' ' + state.endTime;
    //print(startDateTime);
    //print(endDateTime);
    final DateFormat format = new DateFormat("yyyy-MM-dd hh:mm a");

    //print(format.parse(startDateTime));
    //print(format.parse(endDateTime).toIso8601String());

    var appointments = await _appointmentRepository.getAppointmentList(
        token: token, searchParams: state.searchParams);
    emit(state.copywith(appointmentList: appointments));
  }

  void searchPatients({String? query, String? token}) async {
    var patients = await _appointmentRepository.getPatientsList(
        searchParams: query, token: token);
    emit(state.copywith(patientsList: patients));
  }

  void searchDoctors({String? query, String? token}) async {
    emit(state.copywith(searchstate: SEARCHSTATE.startsearch));
    var doctors = await _appointmentRepository.getDoctorList(
        searchParams: query, token: token);
    if (doctors.isNotEmpty) {
      emit(state.copywith(
          doctorsList: doctors, searchstate: SEARCHSTATE.sucessful));
    }
    if (doctors.isEmpty) {
      emit(state.copywith(
          doctorsList: doctors, searchstate: SEARCHSTATE.notFound));
    }
  }

  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copywith(selectedMedicalPersonnel: selectedId));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copywith(selectedPatientId: selectedId));
  }

  void setAppointmentId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copywith(selectedAppointmentId: selectedId));
  }

  void setTypeOfVisit(String? argtypeOfVisit) {
    final String typeofVisit = argtypeOfVisit!;
    emit(state.copywith(typeOfVisit: typeofVisit));
  }

  void setReasonForVisit(String? argresonsforvist) {
    final String resonsForVisiit = argresonsforvist!;
    emit(state.copywith(reasonForVisit: resonsForVisiit));
  }

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;

    emit(state.copywith(searchParams: searchParams));
  }

  void setStartTime(String? argStartTime) {
    final String startTime = argStartTime!;
    emit(state.copywith(startTime: startTime));
  }

  void setEndTime(String? argEndTime) {
    final String endTime = argEndTime!;
    emit(state.copywith(endTime: endTime));
  }

  void setStartDate(String? argStartDate) {
    final String startDate = argStartDate!;
    emit(state.copywith(startDate: startDate));
  }

  void setEndDate(String? argEndDate) {
    final String endDate = argEndDate!;

    emit(state.copywith(endDate: endDate));
  }

  void setDatTimeDateFormat() {}

  void setSelectedMedicalIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;
    emit(state.copywith(seletedMedicalIndex: selectedIndex));
  }

  void setSelectedPatientIndex(int? argSelectedIndex) {
    final int selectedIndex = argSelectedIndex!;

    emit(state.copywith(selctedPatientIndex: selectedIndex));
  }

  Future<Response?> createRegsitration(
      {String? token,
      String? patientID,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? typofVisit}) async {
    Response? req = await _appointmentRepository.createRegisteration(
        token: token,
        patientID: patientID,
        medicalId: medicalId,
        appointmentId: appointmentId,
        reasons: reasons,
        typofVisit: typofVisit);

    emit(state.copywith(patientRegistered: true));

    return req;
  }

  void getRegisterations({String? token}) async {
    var registerationList =
        await _appointmentRepository.getRegisterations(token: token);
        emit(state.copywith(registerationList: registerationList));
  }

  void getAppointments({String? token}) async {
    var  appointList =
        await _appointmentRepository.getRegisterations(token: token);
    emit(state.copywith(appointmentList: appointList));

    //var
  }

  Future<Response?> createAppointmenmt(
      {String? appointmentDateTime,
      String? patientID,
      String? medicalId,
      String? token,
      int? minDuration,
      String? typeOfVisit,
      String? reasonForVisit,
      String? languagePreference}) async {
    Response? req = await _appointmentRepository.CreateAppointment(
        patientID: patientID,
        medicalId: medicalId,
        token: token,
        typofVisit: typeOfVisit,
        reasons: reasonForVisit);

    return req;
  }
}

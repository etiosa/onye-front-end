import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:onye_front_ened/pages/appointment/repository/AppointmentRepository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository _appointmentRepository;
  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments({String? token, String? searchParams}) async {
    emit(state.copywith(searchstate: SEARCHSTATE.inital));

    var appointments = await _appointmentRepository.getAppointmentList(
        token: token, searchParams: state.searchParams);
    emit(state.copywith(appointmentList: appointments));
    if (state.appointmentList.isEmpty) {
      emit(state.copywith(searchstate: SEARCHSTATE.notFound));
    } else {
      emit(state.copywith(searchstate: SEARCHSTATE.sucessful));
    }
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
    getRegisterations(token: token);

    return req;
  }

  void getRegisterations({String? token, String? searchParams}) async {
    emit(state.copywith(searchstate: SEARCHSTATE.inital));
    var registerationList = await _appointmentRepository.getRegisterations(
        token: token, searchParams: searchParams);
    emit(state.copywith(registerationList: registerationList));
    print(registerationList);

    if (state.registerationList.isEmpty) {
      emit(state.copywith(searchstate: SEARCHSTATE.notFound));
    } else {
      emit(state.copywith(searchstate: SEARCHSTATE.sucessful));
      //emit(state.copywith(registerationList: registerationList));

    }
  }

  void getAppointments({String? token}) async {
    var appointList =
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
      String? date,
      String? time,
      String? languagePreference}) async {
    String Date = date!;
    String Time = time!;
    var inputFormat = DateFormat('yyyy-dd-MM hh:mm a');
    var timedate = inputFormat.parse(Date + ' ' + Time, true);
    print(timedate.toIso8601String());

    Response? req = await _appointmentRepository.CreateAppointment(
        date: timedate.toIso8601String(),
        patientID: patientID,
        medicalId: medicalId,
        token: token,
        typofVisit: typeOfVisit,
        reasons: reasonForVisit);

    return req;
  }
}

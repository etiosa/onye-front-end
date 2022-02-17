import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:onye_front_ened/repositories/appointment_repositories/appointment_repositories.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository _appointmentRepository;
  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments() async {
    final String startDateTime = state.startDate + ' ' + state.startTime;
    final String endDateTime = state.endDate + ' ' + state.endTime;
    print(startDateTime);
    print(endDateTime);
    final DateFormat format = new DateFormat("yyyy-MM-dd hh:mm a");

    print(format.parse(startDateTime));
    print(format.parse(endDateTime).toIso8601String());

    var appointments = await _appointmentRepository.getAppointmentList(
        searchParams: state.searchParams);
    emit(state.copywith(appointmentList: appointments));
  }

  void searchPatients({String? query,String? token}) async {
    var patients =
        await _appointmentRepository.getPatientsList(searchParams: query, token: token);
    emit(state.copywith(patientsList: patients));
  }

  void searchDoctors({String? query, String? token}) async {
    emit(state.copywith(searchstate: SEARCHSTATE.startsearch));
    var doctors =
        await _appointmentRepository.getDoctorList(searchParams: query, token: token);
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

  void setPatientId(String? argrSelectedId) {
    final String selectedId = argrSelectedId!;
    emit(state.copywith(selectedPatientId: selectedId));
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

  /* void home({String? tokens}) async {
    final String token = await _authRepository.home(token: tokens);
    emit(state.copywith(token: token));
  } */

}

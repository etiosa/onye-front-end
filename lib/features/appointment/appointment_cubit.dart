import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:onye_front_ened/repositories/appointment_repositories/appointment_repositories.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository _appointmentRepository;
  AppointmentCubit(
    this._appointmentRepository,
  ) : super(const AppointmentState());

  Future<void> searchAppointments() async {
    var appointments = await _appointmentRepository.getAppointmentList(
        searchParams: state.searchParams);
    emit(state.copywith(appointmentList: appointments));
  }

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;
    print(searchParams);
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
    print('startdate');
    print(startDate);
    emit(state.copywith(startDate: startDate));
  }

  void setEndDate(String? argEndDate) {
    final String endDate = argEndDate!;
    print('endDate');
    print(endDate);

    emit(state.copywith(endDate: endDate));
  }
}

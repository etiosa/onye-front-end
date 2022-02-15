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
    print("search appointment called");
    var appointments = await _appointmentRepository.getAppointmentList();
  }
}

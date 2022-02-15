part of 'appointment_cubit.dart';

class AppointmentState extends Equatable {
  const AppointmentState({this.appointmentList=const[]});
  final List<dynamic> appointmentList;

  @override
  List<Object> get props => [appointmentList];
}

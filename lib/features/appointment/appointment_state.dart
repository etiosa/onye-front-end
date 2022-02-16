part of 'appointment_cubit.dart';



class AppointmentState extends Equatable {
  const AppointmentState(
      {this.appointmentList = const [],
      this.patientsList = const [],
      this.searchParams = '',
      this.startDateTime = '',
      this.startDate = '',
      this.endDate = '',
      this.startTime = '',
      this.endTime = '',
      this.doctorsList=const[],
      this.endDateTime = ''});
  final List<dynamic> appointmentList;
  final List<dynamic> patientsList;
  final String searchParams;
  final String startDateTime;
  final String endDateTime;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final List<dynamic> doctorsList;

  @override
  List<Object> get props => [
        appointmentList,
        patientsList,
        searchParams,
        startDateTime,
        endDateTime,
        endDate,
        startDate,
        endTime,
        startTime,
        doctorsList
      ];

  AppointmentState copywith(
      {String? searchParams,
      List<dynamic>? appointmentList,
      List<dynamic>? patientsList,
      List<dynamic>? doctorsList,
    String? startDateTime,
      String? startTime,
      String? endTime,
      String? startDate,
      String? endDate,
      String? endDateTime}) {
    return AppointmentState(
        searchParams: searchParams ?? this.searchParams,
        doctorsList: doctorsList??this.doctorsList,
        endDate: endDate ?? this.endDate,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        startDateTime: startDateTime ?? this.startDateTime,
        endDateTime: endDateTime ?? this.endDateTime,
        appointmentList: appointmentList ?? this.appointmentList,
        patientsList: patientsList ?? this.patientsList);
  }
}

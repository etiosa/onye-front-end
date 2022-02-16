part of 'appointment_cubit.dart';

enum SEARCHSTATE{
  inital,
  sucessful,
  error,
  notFound,
  startsearch
}


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
      this.searchState=SEARCHSTATE.inital,
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
  final SEARCHSTATE searchState;

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
        doctorsList,
        searchState
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
      SEARCHSTATE? searchstate,
      String? endDate,
      String? endDateTime}) {
    return AppointmentState(
      searchState: searchstate ?? searchState,
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

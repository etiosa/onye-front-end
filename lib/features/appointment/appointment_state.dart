part of 'appointment_cubit.dart';

enum SEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum REGISTRATIONsTATE { inita, sucessful, inprogress, failed }

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
      this.searchState = SEARCHSTATE.inital,
      this.doctorsList = const [],
      this.selectedMedicalPeronnelId = '',
      this.selectedPatientId = '',
      this.resonsForVist = '',
      this.typeOfVist = '',
      this.selectedMedicalIndexs = 0,
      this.selectedPatientIndexs = 2,
      this.regState = REGISTRATIONsTATE.inita,
      this.selectedAppointmentId = '',
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
  final String selectedPatientId;
  final String selectedMedicalPeronnelId;
  final List<dynamic> doctorsList;
  final SEARCHSTATE searchState;
  final String typeOfVist;
  final String resonsForVist;
  final int selectedPatientIndexs;
  final int selectedMedicalIndexs;
  final REGISTRATIONsTATE regState;
  final String selectedAppointmentId;

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
        searchState,
        selectedMedicalPeronnelId,
        selectedPatientId,
        typeOfVist,
        resonsForVist,
        selectedMedicalIndexs,
        selectedMedicalIndexs,
        regState,
        selectedAppointmentId,
      ];

  AppointmentState copywith({
    String? searchParams,
    List<dynamic>? appointmentList,
    List<dynamic>? patientsList,
    List<dynamic>? doctorsList,
    String? startDateTime,
    String? startTime,
    String? endTime,
    String? startDate,
    String? selectedPatientId,
    String? selectedMedicalPersonnel,
    SEARCHSTATE? searchstate,
    REGISTRATIONsTATE? regstate,
    String? endDate,
    String? typeOfVisit,
    String? reasonForVisit,
    int? selctedPatientIndex,
    int? seletedMedicalIndex,
    String? endDateTime,
    String? selectedAppointmentId,
  }) {
    return AppointmentState(
        typeOfVist: typeOfVisit ?? typeOfVist,
        regState: regstate ?? regState,
        resonsForVist: reasonForVisit ?? resonsForVist,
        selectedMedicalIndexs:
            seletedMedicalIndex ?? this.selectedMedicalIndexs,
        selectedPatientIndexs:
            selctedPatientIndex ?? this.selectedPatientIndexs,
        // ignore: unnecessary_this
        selectedMedicalPeronnelId:
            selectedMedicalPersonnel ?? selectedMedicalPeronnelId,
        selectedPatientId: selectedPatientId ?? this.selectedPatientId,
        selectedAppointmentId:
            selectedAppointmentId ?? this.selectedAppointmentId,
        searchState: searchstate ?? searchState,
        searchParams: searchParams ?? this.searchParams,
        doctorsList: doctorsList ?? this.doctorsList,
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

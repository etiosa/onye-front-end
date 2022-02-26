part of 'appointment_cubit.dart';

enum SEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum REGISTRATIONSTATE { inita, sucessful, inprogress, failed }

//TODO Create clinical Note Model
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
      this.registrationList = const [],
      this.selectedMedicalPeronnelId = '',
      this.selectedPatientId = '',
      this.resonsForVist = '',
      this.typeOfVist = '',
      this.selectedMedicalIndexs = 0,
      this.selectedPatientIndexs = 2,
      this.regState = REGISTRATIONSTATE.inita,
      this.selectedAppointmentId = '',
      this.patientRegistered = false,
      this.clinicalNote = '',
      this.clinicalNoteTitle = '',
      this.clinicalNoteType='',
      this.endDateTime = ''});
  final List<dynamic> appointmentList;
  final List<dynamic> registrationList;
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
  final REGISTRATIONSTATE regState;
  final selectedAppointmentId;
  final String clinicalNoteTitle;
  final String clinicalNote;
  final String clinicalNoteType;
  final bool patientRegistered;

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
        patientRegistered,
        registrationList,
        clinicalNote,
        clinicalNoteTitle,
        clinicalNoteType,
      ];

  AppointmentState copyWith({
    String? searchParams,
    String? clinicalNoteTitle,
    String? clinicalNote,
    List<dynamic>? appointmentList,
    List<dynamic>? patientsList,
    List<dynamic>? doctorsList,
    String? startDateTime,
    List<dynamic>? registerationList,
    String? startTime,
    String? endTime,
    String? startDate,
    String? selectedPatientId,
    String? selectedMedicalPersonnel,
    SEARCHSTATE? searchstate,
    REGISTRATIONSTATE? regstate,
    bool? patientRegistered,
    String? endDate,
    String? typeOfVisit,
    String? reasonForVisit,
    int? selectedPatientIndex,
    int? selectedMedicalIndex,
    String? endDateTime,
    String? selectedAppointmentId,
    String? clinicalNoteType,
  }) {
    return AppointmentState(
      clinicalNoteType: clinicalNoteType??this.clinicalNoteType,
        clinicalNote: clinicalNote ?? this.clinicalNote,
        clinicalNoteTitle: clinicalNoteTitle ?? this.clinicalNoteTitle,
        patientRegistered: patientRegistered ?? this.patientRegistered,
        registrationList: registerationList ?? this.registrationList,
        typeOfVist: typeOfVisit ?? typeOfVist,
        regState: regstate ?? regState,
        resonsForVist: reasonForVisit ?? resonsForVist,
        selectedMedicalIndexs:
            selectedMedicalIndex ?? this.selectedMedicalIndexs,
        selectedPatientIndexs:
            selectedPatientIndex ?? this.selectedPatientIndexs,
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

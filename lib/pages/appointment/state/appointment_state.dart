part of 'appointment_cubit.dart';

enum SEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum REGISTRATIONSTATE { inita, sucessful, inprogress, failed }

//TODO create modal later
class AppointmentState extends Equatable {
  const AppointmentState(
      {this.appointmentList = const [],
      this.patientsList = const [],
      this.searchParams = '',
      this.startDateTime = '',
      this.startDate = '',
      this.startTime = '',
      this.searchState = SEARCHSTATE.inital,
      this.doctorsList = const [],
      this.registrationList = const [],
      this.selectedMedicalPersonnelId = '',
      this.selectedPatientId = '',
      this.reasonForVisit = '',
      this.typeOfVisit = '',
      this.selectedMedicalIndex = 0,
      this.selectedPatientIndex = 2,
      this.registrationState = REGISTRATIONSTATE.inita,
      this.selectedAppointmentId = '',
      this.patientRegistered = false,
      this.clinicalNote = '',
      this.clinicalNoteTitle = '',
      this.clinicalNoteType = ''});

  final List<dynamic> appointmentList;
  final List<dynamic> registrationList;
  final List<dynamic> patientsList;
  final String searchParams;
  final String startDateTime;
  final String startDate;
  final String startTime;
  final String selectedPatientId;
  final String selectedMedicalPersonnelId;
  final List<dynamic> doctorsList;
  final SEARCHSTATE searchState;
  final String typeOfVisit;
  final String reasonForVisit;
  final int selectedPatientIndex;
  final int selectedMedicalIndex;
  final REGISTRATIONSTATE registrationState;
  final String selectedAppointmentId;
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
        startDate,
        startTime,
        doctorsList,
        searchState,
        selectedMedicalPersonnelId,
        selectedPatientId,
        typeOfVisit,
        reasonForVisit,
        selectedMedicalIndex,
        selectedMedicalIndex,
        registrationState,
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
    List<dynamic>? registrationList,
    String? startTime,
    String? endTime,
    String? startDate,
    String? selectedPatientId,
    String? selectedMedicalPersonnelId,
    SEARCHSTATE? searchState,
    REGISTRATIONSTATE? registrationState,
    bool? patientRegistered,
    String? typeOfVisit,
    String? reasonForVisit,
    int? selectedPatientIndex,
    int? selectedMedicalIndex,
    String? selectedAppointmentId,
    String? clinicalNoteType,
  }) {
    return AppointmentState(
        clinicalNoteType: clinicalNoteType ?? this.clinicalNoteType,
        clinicalNote: clinicalNote ?? this.clinicalNote,
        clinicalNoteTitle: clinicalNoteTitle ?? this.clinicalNoteTitle,
        patientRegistered: patientRegistered ?? this.patientRegistered,
        registrationList: registrationList ?? this.registrationList,
        typeOfVisit: typeOfVisit ?? this.typeOfVisit,
        registrationState: registrationState ?? this.registrationState,
        reasonForVisit: reasonForVisit ?? this.reasonForVisit,
        selectedMedicalIndex: selectedMedicalIndex ?? this.selectedMedicalIndex,
        selectedPatientIndex: selectedPatientIndex ?? this.selectedPatientIndex,
        selectedMedicalPersonnelId: selectedMedicalPersonnelId ?? this.selectedMedicalPersonnelId,
        selectedPatientId: selectedPatientId ?? this.selectedPatientId,
        selectedAppointmentId:
            selectedAppointmentId ?? this.selectedAppointmentId,
        searchState: searchState ?? this.searchState,
        searchParams: searchParams ?? this.searchParams,
        doctorsList: doctorsList ?? this.doctorsList,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        startDateTime: startDateTime ?? this.startDateTime,
        appointmentList: appointmentList ?? this.appointmentList,
        patientsList: patientsList ?? this.patientsList);
  }
}

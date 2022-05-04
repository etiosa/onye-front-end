part of 'appointment_cubit.dart';

enum REGSEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum APPOINTMENTSTATE { inita, sucessful, inprogress, failed }
enum APPOINTMENTLOADSTATE { init, loading, loaded, failed }

//TODO create modal later
class AppointmentState extends Equatable {
  const AppointmentState(
      {this.appointmentList = const [],
      this.patientsList = const [],
      this.searchParams = '',
      this.dateTime = '',
      this.appointmentDate = '',
      this.appointmentTime = '',
      this.searchState = REGSEARCHSTATE.inital,
      this.doctorsList = const [],
      this.registrationList = const [],
      this.selectedMedicalPersonnelId = '',
      this.selectedPatientId = '',
      this.reasonForVisit = '',
      this.typeOfVisit = '',
      this.selectedMedicalIndex = 0,
      this.selectedPatientIndex = 2,
      this.appointmentState = APPOINTMENTSTATE.inita,
      this.selectedAppointmentId = '',
      this.patientRegistered = false,
      this.maxPageNumber = 0,
      this.nextPage = 0,
      this.fromDate = '',
      this.fromTime = '',
      this.toDate = '',
      this.appointmentError = '',
      this.apploadState=APPOINTMENTLOADSTATE.init,
      this.toTime = ''});

  final List<dynamic> appointmentList;
  final List<dynamic> registrationList;
  final List<dynamic> patientsList;
  final String searchParams;
  final String dateTime;
  final String appointmentDate;
  final String appointmentTime;
  final String selectedPatientId;
  final String selectedMedicalPersonnelId;
  final List<dynamic> doctorsList;
  final REGSEARCHSTATE searchState;
  final String typeOfVisit;
  final String reasonForVisit;
  final int selectedPatientIndex;
  final int selectedMedicalIndex;
  final APPOINTMENTSTATE appointmentState;
  final String selectedAppointmentId;
  final bool patientRegistered;
  final int maxPageNumber;
  final int nextPage;
  final String fromDate;
  final String fromTime;
  final String toDate;
  final String toTime;
  final APPOINTMENTLOADSTATE apploadState;
  final String appointmentError;

  @override
  List<Object> get props => [
        appointmentList,
        patientsList,
        searchParams,
        dateTime,
        appointmentDate,
        appointmentTime,
        doctorsList,
        searchState,
        selectedMedicalPersonnelId,
        selectedPatientId,
        typeOfVisit,
        reasonForVisit,
        selectedMedicalIndex,
        selectedMedicalIndex,
        appointmentState,
        selectedAppointmentId,
        patientRegistered,
        registrationList,
        maxPageNumber,
        nextPage,
        fromDate,
        fromTime,
        toDate,
        toTime,
        apploadState,
        appointmentError
      ];

  AppointmentState copyWith(
      {String? searchParams,
      APPOINTMENTLOADSTATE? appointmentloadState,
      String? appointmenterror,
      String? clinicalNoteTitle,
      String? clinicalNote,
      String? clinicalNoteID,
      List<dynamic>? appointmentList,
      List<dynamic>? patientsList,
      List<dynamic>? doctorsList,
      List<dynamic>? registrationList,
      String? dateTime,
      String? appointmentTime,
      String? appointmentDate,
      String? selectedPatientId,
      String? selectedMedicalPersonnelId,
      APPOINTMENTSTATE? appointmentstate,
      bool? patientRegistered,
      String? typeOfVisit,
      String? reasonForVisit,
      int? selectedPatientIndex,
      int? selectedMedicalIndex,
      String? selectedAppointmentId,
      String? clinicalNoteType,
      int? nextPage,
      int? maxPageNumber,
      String? fromDate,
      String? fromTime,
      String? toDate,
      String? toTime,
      REGSEARCHSTATE? searchState}) {
    return AppointmentState(
      apploadState: appointmentloadState?? apploadState,
      appointmentError: appointmenterror ?? appointmentError,
      nextPage: nextPage ?? this.nextPage,
      maxPageNumber: maxPageNumber ?? this.maxPageNumber,
      patientRegistered: patientRegistered ?? this.patientRegistered,
      registrationList: registrationList ?? this.registrationList,
      typeOfVisit: typeOfVisit ?? this.typeOfVisit,
      appointmentState: appointmentstate ?? appointmentState,
      reasonForVisit: reasonForVisit ?? this.reasonForVisit,
      selectedMedicalIndex: selectedMedicalIndex ?? this.selectedMedicalIndex,
      selectedPatientIndex: selectedPatientIndex ?? this.selectedPatientIndex,
      selectedMedicalPersonnelId:
          selectedMedicalPersonnelId ?? this.selectedMedicalPersonnelId,
      selectedPatientId: selectedPatientId ?? this.selectedPatientId,
      selectedAppointmentId:
          selectedAppointmentId ?? this.selectedAppointmentId,
      searchState: searchState ?? this.searchState,
      searchParams: searchParams ?? this.searchParams,
      doctorsList: doctorsList ?? this.doctorsList,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      dateTime: dateTime ?? this.dateTime,
      appointmentList: appointmentList ?? this.appointmentList,
      patientsList: patientsList ?? this.patientsList,
      fromDate: fromDate ?? this.fromDate,
      fromTime: fromTime ?? this.fromTime,
      toDate: toDate ?? this.toDate,
      toTime: toTime ?? this.toTime,
    );
  }
}

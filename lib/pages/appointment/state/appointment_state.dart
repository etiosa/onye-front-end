part of 'appointment_cubit.dart';

enum REGSEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum REGISTRATIONSTATE { inita, sucessful, inprogress, failed }

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
      this.registrationState = REGISTRATIONSTATE.inita,
      this.selectedAppointmentId = '',
      this.patientRegistered = false,
 
      this.maxPageNumber = 0,
      this.nextPage = 0,
      });

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
  final REGISTRATIONSTATE registrationState;
  final String selectedAppointmentId;
  final bool patientRegistered;
  final int maxPageNumber;
  final int nextPage;

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
        registrationState,
        selectedAppointmentId,
        patientRegistered,
        registrationList,
      
        maxPageNumber,
        nextPage,
      
      ];

  AppointmentState copyWith(
      {String? searchParams,
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
      REGSEARCHSTATE? searchState,
      REGISTRATIONSTATE? registrationState,
      bool? patientRegistered,
      String? typeOfVisit,
      String? reasonForVisit,
      int? selectedPatientIndex,
      int? selectedMedicalIndex,
      String? selectedAppointmentId,
      String? clinicalNoteType,
      int? nextPage,
      int? maxPageNumber}) {
    return AppointmentState(
        nextPage: nextPage ?? this.nextPage,
        maxPageNumber: maxPageNumber ?? this.maxPageNumber,
        patientRegistered: patientRegistered ?? this.patientRegistered,
        registrationList: registrationList ?? this.registrationList,
        typeOfVisit: typeOfVisit ?? this.typeOfVisit,
        registrationState: registrationState ?? this.registrationState,
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
        patientsList: patientsList ?? this.patientsList);
  }
}

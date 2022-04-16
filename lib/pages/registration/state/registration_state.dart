part of 'registration_cubit.dart';

enum REGISTRATIONSTATE { init, sucessful, inprogress, failed }
enum SEARCHSTATE { inital, sucessful, error, notFound, startsearch }

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.registrationList = const [],
      this.searchParams = '',
      this.searchState = SEARCHSTATE.inital,
      this.patientList = const [],
      this.typeOfVisit = '',
      this.reasonForVisit = '',
      this.nextPage = 0,
      this.maxPageNumber = 0,
      this.selectedMedicalPersonnelId='',
      this.selectedPatientId='',
      this.selectedPatientIndex = 0});

  final List<dynamic> registrationList;
  final List<dynamic> patientList;
  final String typeOfVisit;
  final String reasonForVisit;
  final int selectedPatientIndex;
  final String searchParams;
  final int nextPage;
  final int maxPageNumber;
  final String selectedMedicalPersonnelId;
  final String selectedPatientId;

  final SEARCHSTATE searchState;

  @override
  // TODO: implement props
  List<Object?> get props => [
        registrationList,
        typeOfVisit,
        reasonForVisit,
        selectedPatientIndex,
        searchParams,
        patientList,
        maxPageNumber,
        selectedMedicalPersonnelId,
        selectedPatientId,
        searchState,
        nextPage
      ];

  RegistrationState copyWith(
      {String? searchParams,
      List<dynamic>? registrationList,
      List<dynamic>? patientList,
      String? selectedPatientId,
      REGISTRATIONSTATE? registrationState,
      String? typeOfVisit,
      String? reasonForVisit,
      SEARCHSTATE? searchState,
      int? selectedPatientIndex,
      int? nextPage,
    String? selectedMedicalPersonnelId,      
      int? maxPageNumber}) {
    return RegistrationState(
      selectedMedicalPersonnelId: selectedMedicalPersonnelId?? this.selectedMedicalPersonnelId,
      selectedPatientId: selectedPatientId?? this.selectedPatientId,
        maxPageNumber: maxPageNumber ?? this.maxPageNumber,
        nextPage: nextPage ?? this.nextPage,
        patientList: patientList ?? this.patientList,
        searchState: searchState ?? this.searchState,
        registrationList: registrationList ?? this.registrationList,
        typeOfVisit: typeOfVisit ?? this.typeOfVisit,
        reasonForVisit: reasonForVisit ?? this.reasonForVisit,
        selectedPatientIndex:
            selectedPatientIndex ?? this.selectedPatientIndex);
  }
}

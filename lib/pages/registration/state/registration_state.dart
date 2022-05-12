part of 'registration_cubit.dart';

enum REGISTRATIONSTATE { init, sucessful, inprogress, failed }
enum SEARCHSTATE { inital, sucessful, error, notFound, startsearch }
enum REGISTERSTATELOAD { init, loading, loaded, failed }

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
      this.selectedMedicalPersonnelId = '',
      this.selectedPatientId = '',
      this.registrationError = '',
      this.maxPatientPageNumber = 0,
      this.registerstateload = REGISTERSTATELOAD.init,
      this.registerState = REGISTRATIONSTATE.init,
      this.registrationStartDate = '',
      this.registrationStartTime = '',
      this.registrationEndDate = '',
      this.registrationEndTime = '',
      this.type='',
      this.selectedPatientIndex = 0});

  final List<dynamic> registrationList;
  final List<dynamic> patientList;
  final String typeOfVisit;
  final String reasonForVisit;
  final int selectedPatientIndex;
  final String searchParams;
  final int nextPage;
  final String type;
  final int maxPageNumber;
  final int maxPatientPageNumber;
  final String selectedMedicalPersonnelId;
  final String selectedPatientId;
  final String registrationError;
  final SEARCHSTATE searchState;
  final REGISTERSTATELOAD registerstateload;
  final REGISTRATIONSTATE registerState;
  final String registrationStartTime;
  final String registrationStartDate;
  final String registrationEndDate;
  final String registrationEndTime;
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
        nextPage,
        maxPatientPageNumber,
        registrationError,
        registerState,
        registerstateload,
        registrationStartTime,
        registrationStartDate,
        registrationEndDate,
        registrationEndTime,
        type
      ];

  RegistrationState copyWith(
      {String? searchParams,
      String? registrationEndDate,
      String? registrationEndTime,
      String? registrationStartDate,
      String? registrationStartTime,
      REGISTERSTATELOAD? regLoad,
      List<dynamic>? registrationList,
      List<dynamic>? patientList,
      String? selectedPatientId,
      REGISTRATIONSTATE? registerState,
      String? typeOfVisit,
      String? reasonForVisit,
      SEARCHSTATE? searchState,
      int? selectedPatientIndex,
      String? registrationError,
      int? nextPage,
      String? type,
      int? maxPatientPageNumber,
      String? selectedMedicalPersonnelId,
      int? maxPageNumber}) {
    return RegistrationState(
      type: type??this.type,
        registrationEndDate: registrationEndDate ?? this.registrationEndDate,
        registrationEndTime: registrationEndTime ?? this.registrationEndTime,
        registrationStartDate: registrationStartDate ?? this.registrationStartDate,
        registrationStartTime: registrationStartTime ?? this.registrationStartTime,
        registerstateload: regLoad ?? registerstateload,
        registerState: registerState ?? this.registerState,
        registrationError: registrationError ?? this.registrationError,
        maxPatientPageNumber: maxPatientPageNumber ?? this.maxPatientPageNumber,
        selectedMedicalPersonnelId:
            selectedMedicalPersonnelId ?? this.selectedMedicalPersonnelId,
        selectedPatientId: selectedPatientId ?? this.selectedPatientId,
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

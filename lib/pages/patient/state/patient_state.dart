part of 'patient_cubit.dart';

enum PATIENTSEARCHSTATE { inital, sucessful, error, notFound, startsearch }

enum PATIENTCREATION { init, inprogress, error, created, unknown }

enum PATIENTEDITSTATE { init, inprogress, save, error, unknown }

enum FETCHPATIENTSTATE { init, inprogress, fetch, error, unknownm }

//TODO: Refactor
class PatientState extends Equatable {
  const PatientState({
    this.firstName,
    this.middleName,
    this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.religion,
    required this.educationLevel,
    this.phoneNumber,
    this.email,
    this.contactPreferences = '',
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.zipCode,
    required this.ethnicity,
    this.allOptions = const {},
    this.appointmentList = const [],
    this.emergencyContactName,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelationship,
    this.contactPreference,
    this.token = '',
    this.query = '',
    this.searchState = PATIENTSEARCHSTATE.inital,
    this.createdPatientData = const {},
    this.patientsList = const [],
    this.selectedPatientId = '',
    this.maxPageNumber = 0,
    this.nextPage = 0,
    this.patientcreation = PATIENTCREATION.init,
    this.searchParams = '',
    this.fetchpatientstate=FETCHPATIENTSTATE.init,
    this.patienteditstate= PATIENTEDITSTATE.init
  });

  final FETCHPATIENTSTATE? fetchpatientstate;
  final PATIENTEDITSTATE? patienteditstate;
  final String? firstName;
  final PATIENTCREATION patientcreation;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? gender;
  final String? religion;
  final String? educationLevel;
  final String? phoneNumber;
  final String? email;
  final PATIENTSEARCHSTATE searchState;
  final String? token;
  final String? contactPreferences;
  final String? addressLine1;
  final String? addressLine2;
  final String? zipCode;
  final String? query;
  final String? city;
  final String? ethnicity;
  final String? contactPreference;
  final String? emergencyContactRelationship;
  final String? emergencyContactName;
  final List<dynamic> appointmentList;
  final Map<String, dynamic> allOptions;
  final dynamic createdPatientData;
  final String? emergencyContactPhoneNumber;
  final List<dynamic> patientsList;
  final String selectedPatientId;
  final int maxPageNumber;
  final int nextPage;
  final String searchParams;

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        dateOfBirth,
        gender,
        religion,
        educationLevel,
        phoneNumber,
        email,
        contactPreferences,
        zipCode,
        addressLine1,
        addressLine2,
        city,
        allOptions,
        appointmentList,
        ethnicity,
        emergencyContactName,
        emergencyContactPhoneNumber,
        emergencyContactRelationship,
        contactPreference,
        createdPatientData,
        searchState,
        query,
        patientsList,
        selectedPatientId,
        maxPageNumber,
        nextPage,
        searchParams,
        patientcreation,
        patienteditstate,
        fetchpatientstate
      ];

  PatientState copyWith(
      {String? firstName,
      FETCHPATIENTSTATE? fetchpatientstate,
      PATIENTEDITSTATE? patienteditstate,
      PATIENTCREATION? patientcreation,
      String? middleName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? query,
      String? religion,
      String? educationLevel,
      String? email,
      String? ethnicity,
      int? nextPage,
      PATIENTSEARCHSTATE? searchState,
      String? toke,
      String? emergencyContactName,
      String? emergencyContactPhoneNumber,
      List<dynamic>? appointmentList,
      String? phoneNumber,
      String? zipcode,
      String? contactPreference,
      String? addressLine1,
      String? addressLine2,
      String? zipCode,
      dynamic createdPatientData,
      String? emergencyContactRelationship,
      String? city,
      Map<String, dynamic>? allOptions,
      String? contactPreferences,
      List<dynamic>? patientsList,
      String? selectedPatientId,
      String? searchParams,
      int? maxPageNumber}) {
    return PatientState(
      fetchpatientstate: fetchpatientstate?? this.fetchpatientstate,
      patienteditstate: patienteditstate?? this.patienteditstate,
        patientcreation: patientcreation ?? this.patientcreation,
        token: toke ?? token,
        searchParams: searchParams ?? this.searchParams,
        nextPage: nextPage ?? this.nextPage,
        maxPageNumber: maxPageNumber ?? this.maxPageNumber,
        selectedPatientId: selectedPatientId ?? this.selectedPatientId,
        patientsList: patientsList ?? this.patientsList,
        query: query ?? this.query,
        searchState: searchState ?? this.searchState,
        createdPatientData: createdPatientData ?? this.createdPatientData,
        firstName: firstName ?? this.firstName,
        emergencyContactName: emergencyContactName ?? this.emergencyContactName,
        ethnicity: ethnicity ?? this.ethnicity,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        religion: religion ?? this.religion,
        educationLevel: educationLevel ?? this.educationLevel,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        contactPreferences: contactPreferences ?? this.contactPreferences,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        zipCode: zipCode ?? this.zipCode,
        allOptions: allOptions ?? this.allOptions,
        contactPreference: contactPreferences ?? this.contactPreferences,
        emergencyContactRelationship:
            emergencyContactRelationship ?? this.emergencyContactRelationship,
        emergencyContactPhoneNumber:
            emergencyContactPhoneNumber ?? this.emergencyContactPhoneNumber,
        appointmentList: appointmentList ?? this.appointmentList,
        city: city ?? this.city);
  }
}

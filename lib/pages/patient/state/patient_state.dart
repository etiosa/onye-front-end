part of 'patient_cubit.dart';

enum REGISTERATIONSEARCHSTATE {
  inital,
  sucessful,
  error,
  notFound,
  startsearch
}

//TODO: Refactor
class PatientState extends Equatable {
  const PatientState(
      {this.firstName,
      this.middleName,
      this.lastName,
      required this.dateOfBirth,
      required this.gender,
      required this.religion,
      required this.educationLevel,
      this.phoneNumber,
      this.email,
      this.contactPreferences,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.addressLine4,
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
      this.query='',
      this.searchState = REGISTERATIONSEARCHSTATE.inital,
      this.createdPatientData = const {},
      this.registrationFormState = RegistrationFormState.init});

//selcted value
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? gender;
  final String? religion;
  final String? educationLevel;
  final String? phoneNumber;
  final String? email;
  final REGISTERATIONSEARCHSTATE searchState;
  final String? token;
  final String? contactPreferences;
  final String? addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final String? addressLine4;
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
  final RegistrationFormState registrationFormState;
  final String? emergencyContactPhoneNumber;

  @override
  List<Object?> get props => [
        firstName,
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
        addressLine3,
        addressLine4,
        emergencyContactName,
        emergencyContactPhoneNumber,
        emergencyContactRelationship,
        contactPreference,
        createdPatientData,
        searchState,
        query
      ];

  PatientState copywith(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? query,
      String? religion,
      String? educationLevel,
      String? email,
      String? ethnicity,
      String? addressLine3,
      REGISTERATIONSEARCHSTATE? searchState,
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
      String? addressLine4,
      Map<String, dynamic>? allOptions,
      RegistrationFormState? registrationFormState,
      String? contactPreferences}) {
    return PatientState(
        token: toke ?? token,
        query: query?? this.query,
        searchState: searchState ?? this.searchState,
        createdPatientData: createdPatientData ?? this.createdPatientData,
        firstName: firstName ?? this.firstName,
        emergencyContactName: emergencyContactName ?? this.emergencyContactName,
        ethnicity: ethnicity ?? this.ethnicity,
        middleName: middleName ?? this.middleName,
        addressLine4: addressLine4 ?? this.addressLine4,
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
        addressLine3: addressLine3 ?? this.addressLine3,
        allOptions: allOptions ?? this.allOptions,
        contactPreference: contactPreferences ?? this.contactPreferences,
        emergencyContactRelationship:
            emergencyContactRelationship ?? this.emergencyContactRelationship,
        emergencyContactPhoneNumber:
            emergencyContactPhoneNumber ?? this.emergencyContactPhoneNumber,
        appointmentList: appointmentList ?? this.appointmentList,
        registrationFormState:
            registrationFormState ?? this.registrationFormState,
        city: city ?? this.city);
  }
}

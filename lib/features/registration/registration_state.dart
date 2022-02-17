part of 'registration_cubit.dart';

enum RegistrationFormState { init, fail, scuessful }

//TODO: Refactor
class RegistrationState extends Equatable {
  const RegistrationState(
      {this.firstName = '',
      this.middleName = '',
      this.lastName = '',
      this.dateOfBirth = '',
      required this.gender,
      required this.religion,
      required this.educationLevel,
      this.phoneNumber = '',
      this.email = '',
      this.contactPreferences = '',
      this.countryCode = '',
      this.addressLine1 = '',
      this.addressLine2 = '',
      this.city = '',
      this.zipCode = '',
      this.ethnicity = '',
      this.addressLine3 = '',
      this.addressLine4 = '',
      this.allOptions = const {},
      this.appointmentList = const [],
      this.emergencyContactName = '',
      this.emergencyContactPhoneNumber = '',
      this.emergencyContactRelationship = '',
      this.contactPrefernce = '',
      this.token='',
      this.registrationFormState = RegistrationFormState.init});

//selcted value
  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String religion;
  final String educationLevel;
  final String phoneNumber;
  final String email;
  final String token;
  final String contactPreferences;
  final String countryCode;
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String addressLine4;
  final String zipCode;
  final String city;
  final String ethnicity;
  final String contactPrefernce;
  final String emergencyContactRelationship;
  final String emergencyContactName;
  final List<dynamic> appointmentList;
  final Map<String, dynamic> allOptions;
  final RegistrationFormState registrationFormState;
  final String emergencyContactPhoneNumber;

  @override
  List<Object> get props => [
        firstName,
        lastName,
        dateOfBirth,
        gender,
        religion,
        educationLevel,
        phoneNumber,
        email,
        contactPreferences,
        countryCode,
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
        contactPrefernce
      ];

  RegistrationState copywith(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? religion,
      String? educationLevel,
      String? email,
      String? ethnicity,
      String? addressLine3,
      String? toke,
      String? emergencyContactName,
      String? emergencyContactPhoneNumber,
      List<dynamic>? appointmentList,
      String? phoneNumber,
      String? countryCode,
      String? zipcode,
      String? contactPrefernce,
      String? addressLine1,
      String? addressLine2,
      String? zipCode,
      String? emergencyContactRelationship,
      String? city,
      String? addressLine4,
      Map<String, dynamic>? allOptions,
      RegistrationFormState? registrationFormState,
      String? contactPreferences}) {
    return RegistrationState(
      token: toke?? token,
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
        countryCode: countryCode ?? this.countryCode,
        contactPreferences: contactPreferences ?? this.contactPreferences,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        zipCode: zipCode ?? this.zipCode,
        addressLine3: addressLine3 ?? this.addressLine3,
        allOptions: allOptions ?? this.allOptions,
        contactPrefernce: contactPreferences ?? this.contactPreferences,
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

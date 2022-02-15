part of 'registration_cubit.dart';

enum RegistrationFormState { init, fail, scuessful }

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
      this.ethnicity='',
      this.addressLine3='',
      this.addressLine4='',
      this.allOptions = const {},
      this.appointmentList = const [],
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
  final String contactPreferences;
  final String countryCode;
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String addressLine4;
  final String zipCode;
  final String city;
  final String ethnicity;
  final List<dynamic> appointmentList;
  final Map<String, dynamic> allOptions;
  final RegistrationFormState registrationFormState;

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
        addressLine4
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
      List<dynamic>? appointmentList,
      String? phoneNumber,
      String? countryCode,
      String? zipcode,
      String? addressLine1,
      String? addressLine2,
      String? zipCode,
      String? city,
      String? addressLine4,
      Map<String, dynamic>? allOptions,
      RegistrationFormState? registrationFormState,
      String? contactPreferences}) {
    return RegistrationState(
        firstName: firstName ?? this.firstName,
        ethnicity:ethnicity ?? this.ethnicity,
        middleName: middleName ?? this.middleName,
        addressLine4:addressLine4??this.addressLine4,
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
        addressLine3:addressLine3?? this.addressLine3,
        allOptions: allOptions ?? this.allOptions,
        appointmentList: appointmentList ?? this.appointmentList,
        registrationFormState:
            registrationFormState ?? this.registrationFormState,
        city: city ?? this.city);
  }
}

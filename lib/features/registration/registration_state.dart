part of 'registration_cubit.dart';

enum RegistrationFormState { init, fail, scuessful }

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.firstName = 'a',
      this.lastName = 'a',
      this.dateOfBirth = '',
      required this.gender,
      required this.religion,
      required this.educationLevel,
      this.phoneNumber = '111-92-2213',
      this.email = 'test@gmail.com',
      this.contactPreferences = 'default',
      this.countryCode = '1',
      this.addressLine1 = '123 webster ave',
      this.addressLine2 = 'optional',
      this.city = 'Test',
      this.zipCode = '10245',
      this.allOptions= const {},
      this.appointmentList= const[],
      this.registrationFormState = RegistrationFormState.init});

//selcted value
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final List<String> gender;
  final List<String> religion;
  final List<String> educationLevel;
  final String phoneNumber;
  final String email;
  final String contactPreferences;
  final String countryCode;
  final String addressLine1;
  final String addressLine2;
  final String zipCode;
  final String city;
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
        appointmentList
      ];

  RegistrationState copywith(
      {String? firstName,
      String? lastName,
      String? dateOfBirth,
      List<String>? gender,
      List<String>? religion,
      List<String>? educationLevel,
      String? email,
      List<dynamic>? appointmentList,
      String? phoneNumber,
      String? countryCode,
      String? zipcode,
      String? addressLine1,
      String? addressLine2,
      String? zipCode,
      String? city,
      Map<String, dynamic>? allOptions,
      RegistrationFormState? registrationFormState,
      String? contactPreferences}) {
    return RegistrationState(
        firstName: firstName ?? this.firstName,
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
        allOptions: allOptions?? this.allOptions,
        appointmentList:appointmentList??this.appointmentList,
        
        registrationFormState:
            registrationFormState ?? this.registrationFormState,
        city: city ?? this.city);
  }
}

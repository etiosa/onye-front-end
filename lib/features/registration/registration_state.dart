part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.firstName = 'a',
      this.lastName = 'a',
      this.dateOfBirth = 'a',
      this.gender = 'a',
      this.religion = 'a',
      this.educationLevel = 'a',
      this.phoneNumber = '111-92-2213',
      this.email = 'test@gmail.com',
      this.contactPreferences = 'default',
      this.countryCode = '1',
      this.addressLine1 = '123 webster ave',
      this.addressLine2 = 'optional',
      this.city='Test',
      this.zipCode = '10245'});
  final String firstName;
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
  final String zipCode;
  final String city;

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
        city
      ];

  RegistrationState copywith(
      {String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? religion,
      String? educationLevel,
      String? email,
      String? phoneNumber,
      String? countryCode,
      String? zipcode,
      String? addressLine1,
      String? addressLine2,
      String? zipCode,
      String? city,
      String? contactPreferences}) {
    return RegistrationState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.dateOfBirth,
      religion: religion ?? this.religion,
      educationLevel: educationLevel ?? this.educationLevel,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      contactPreferences: contactPreferences ?? this.contactPreferences,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      zipCode: zipCode ?? this.zipCode,
      city: city?? this.city
    );
  }
}

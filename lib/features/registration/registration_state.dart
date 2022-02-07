part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState({this.firstName='', this.lastName='', this.dateOfBirth='',
      this.gender='', this.religion='', this.educationLevel=''});
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String religion;
  final String educationLevel;

  @override
  List<Object> get props =>
      [firstName, lastName, dateOfBirth, gender, religion, educationLevel];

  RegistrationState copywith(
      {String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? religion,
      String? educationLevel}) {
    return RegistrationState(firstName:firstName ?? this.firstName,
              lastName: lastName ??this.lastName,
              dateOfBirth: dateOfBirth ?? this.dateOfBirth,
              gender: gender?? this.dateOfBirth,
              religion: religion ?? this.religion,
              educationLevel: educationLevel??this.educationLevel

    );
  }
}

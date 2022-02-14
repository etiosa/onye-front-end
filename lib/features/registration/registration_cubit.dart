import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onye_front_ened/repositories/registration_repositories/registrationRepositories.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepositories _registrationRepositories;

  RegistrationCubit(this._registrationRepositories)
      : super(const RegistrationState(
            educationLevel: "", gender: "", religion: ""));

  void setFirstName(String? argFirstName) {
    final String firstName = argFirstName!;
    emit(state.copywith(firstName: firstName));
  }

  void setMiddleName(String? argMiddleName) {
    final String middleName = argMiddleName!;
    emit(state.copywith(middleName: middleName));
  }

  void setLastName(String? argLastName) {
    final String lastName = argLastName!;
    emit(state.copywith(lastName: lastName));
  }

  void setDateofBirth(String? argDateOfBirth) {
    final String dateOfBirth = argDateOfBirth!;
    emit(state.copywith(dateOfBirth: dateOfBirth));
  }

  void register() async {
    await _registrationRepositories.createNewPatient(
        firstName: state.firstName,
        middleName: state.middleName,
        lastName: state.lastName,
        phoneNumber: state.phoneNumber,
        gender: state.gender,
        religion: state.religion,
        educationLevel: state.educationLevel,
        contactPreferences: state.contactPreferences,
        addressLine1: state.addressLine1,
        zipCode: state.zipCode,
        city: state.city,
        email: state.email,
        addressLine2: state.addressLine2,
        dateOfBirth: state.dateOfBirth,
        countryCode: state.countryCode);
  }

  void getAppointments() async {
    var appointList = await _registrationRepositories.getAppointment();

    emit(state.copywith(appointmentList: appointList));
  }
}

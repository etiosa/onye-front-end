import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onye_front_ened/repositories/registration_repositories/registrationRepositories.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepositories _registrationRepositories;

  RegistrationCubit(this._registrationRepositories)
      : super(const RegistrationState(
            educationLevel: [], gender: [], religion: []));

  void setFirstName(String? argFirstName) {
    final String firstName = argFirstName!;
    emit(state.copywith(firstName: firstName));
  }

  void setLastName(String? argLastName) {
    final String lastName = argLastName!;
    emit(state.copywith(lastName: lastName));
  }

  void setDateofBirth(String? argDateOfBirth) {
    final String dateOfBirth = argDateOfBirth!;
    emit(state.copywith(dateOfBirth: dateOfBirth));
  }

  void setEducationLevel() async {
    /* Stop calling getDropDown
      Store this in dropwown object in state
    */

    var dropdown = await _registrationRepositories.getFormDropDown();
    print('set education level');
    // List<String> educationLevel = dropdown['educationLevel'];
    // print(educationLevel.length);

    //emit(state.copywith(educationLevel: dropdown['educationLevel']));
  }

  void setGender() async {
    var dropdown = await _registrationRepositories.getFormDropDown();
    print('setGender');
    //emit(state.copywith(educationLevel: dropdown['gender']));
  }

  void setReligion() async {
    var dropdown = await _registrationRepositories.getFormDropDown();
    //emit(state.copywith(educationLevel: dropdown['religion']));
  }

  void register() async {
    await _registrationRepositories.createNewPatient(
        firstName: state.firstName,
        lastName: state.lastName,
        phoneNumber: state.phoneNumber,
        /*  gender: state.gender,
        religion: state.religion,
        educationLevel: state.educationLevel, */
        contactPreferences: state.contactPreferences,
        addressLine1: state.addressLine1,
        zipCode: state.zipCode,
        city: state.city,
        email: state.email,
        addressLine2: state.addressLine2,
        dateOfBirth: state.dateOfBirth,
        countryCode: state.countryCode);
  }

  void getDropDown() async {
    await _registrationRepositories.getFormDropDown();
  }

  void getAppointments() async {
    var appointList = await _registrationRepositories.getAppointment();
   // print(appointList);

    emit(state.copywith(appointmentList: appointList));
  }
}

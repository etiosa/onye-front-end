import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:onye_front_ened/pages/patient/repository/patientRepository.dart';
import 'package:onye_front_ened/pages/schedule/cubit/schedule_cubit.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepositories _registrationRepositories;

  PatientCubit(this._registrationRepositories)
      : super(const PatientState(
          dateOfBirth: '',
          gender: '',
          religion: '',
          educationLevel: '',
          ethnicity: '',
        ));

  void setSearchQuery(String? query) {
    final String searchQuery = query!;
    emit(state.copyWith(query: searchQuery));
  }

  void setFirstName(String? argFirstName) {
    final String firstName = argFirstName!;
    emit(state.copyWith(firstName: firstName));
  }

  void setMiddleName(String? argMiddleName) {
    final String middleName = argMiddleName!;
    emit(state.copyWith(middleName: middleName));
  }

  void setLastName(String? argLastName) {
    final String lastName = argLastName!;
    emit(state.copyWith(lastName: lastName));
  }

  void setDateOfBirth(String? argDateOfBirth) {
    final String dateOfBirth = argDateOfBirth!;
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void setGender(String? argGender) {
    final String gender = argGender!;
    emit(state.copyWith(gender: gender));
  }

  void setReligion(String? argReligion) {
    final String religion = argReligion!;
    emit(state.copyWith(religion: religion));
  }

  void setEducationLevel(String? argEducationLevel) {
    final String educationLevel = argEducationLevel!;
    emit(state.copyWith(educationLevel: educationLevel));
  }

  void setEthnicity(String? argEthnicity) {
    final String ethnicity = argEthnicity!;
    emit(state.copyWith(ethnicity: ethnicity));
  }

  void setPhoneNumber(String? argPhoneNumber) {
    final String phoneNumber = argPhoneNumber!;
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void setEmail(String? argEmail) {
    final String email = argEmail!;
    emit(state.copyWith(email: email));
  }

  void setAddressLine1(String? argAddressLine1) {
    final String addressLine1 = argAddressLine1!;
    emit(state.copyWith(addressLine1: addressLine1));
  }

  void setAddressLine2(String? argAddressLine2) {
    final String addressLine2 = argAddressLine2!;
    emit(state.copyWith(addressLine2: addressLine2));
  }

  void setCity(String? argCity) {
    final String? city = argCity!;
    emit(state.copyWith(city: city));
  }

  void setEmergencyContactName(String? argContactName) {
    final String? contactName = argContactName!;
    emit(state.copyWith(emergencyContactName: contactName));
  }

  void setEmergencyContactPhoneNumber(String? argPhoneNumber) {
    final String? contactPhoneNumber = argPhoneNumber!;
    emit(state.copyWith(emergencyContactPhoneNumber: contactPhoneNumber));
  }

  void setEmergencyContactRelationship(String? argRelationship) {
    final String? contactRelationship = argRelationship!;
    emit(state.copyWith(emergencyContactRelationship: contactRelationship));
  }

  void setContactPreference(String? argContactPreference) {
    final String contactPreference = argContactPreference!;
    emit(state.copyWith(contactPreferences: contactPreference));
  }

  void setZipCode(String? argZipcode) {
    final String zipcode = argZipcode!;
    emit(state.copyWith(zipCode: zipcode));
  }

  Future<Response?> createNewPatient({String? token}) async {

    String? dateOfBirth;
    if (state.dateOfBirth != null && state.dateOfBirth!.isEmpty) {
      dateOfBirth = null;
    } else {
      dateOfBirth = state.dateOfBirth;
    }

    Response? response = await _registrationRepositories.createNewPatient(
        token: token,
        firstName: state.firstName?.trim(),
        middleName: state.middleName?.trim(),
        lastName: state.lastName?.trim(),
        dateOfBirth: dateOfBirth,
        phoneNumber: state.phoneNumber?.trim(),
        gender: state.gender,
        religion: state.religion,
        educationLevel: state.educationLevel,
        contactPreference: state.contactPreferences,
        addressLine1: state.addressLine1?.trim(),
        addressLine2: state.addressLine2?.trim(),
        zipCode: state.zipCode?.trim(),
        city: state.city?.trim(),
        email: state.email?.trim(),
        ethnicity: state.ethnicity,
        emergencyContactName: state.emergencyContactName?.trim(),
        emergencyContactPhoneNumber: state.emergencyContactPhoneNumber?.trim(),
        emergencyContactRelationship: state.emergencyContactRelationship?.trim(),
        countryCode: 'NG');

    return response;
  }

  void clearState() {
    emit(const PatientState(
      dateOfBirth: '',
      gender: '',
      religion: '',
      educationLevel: '',
      ethnicity: '',
    ));
  }
}

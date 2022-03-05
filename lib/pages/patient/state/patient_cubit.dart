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
            dateOfBirth: "",
            educationLevel: "",
            gender: "",
            religion: "",
            ethnicity: ""));

  void setFirstName(String? argFirstName) {
    final String firstName = argFirstName!;
    emit(state.copywith(firstName: firstName));
  }

  void setSearchQuery(String? query) {
    final String searchQuery = query!;
    emit(state.copywith(query: searchQuery));
  }

  void setMiddleName(String? argMiddleName) {
    final String middleName = argMiddleName!;
    emit(state.copywith(middleName: middleName));
  }

  void setLastName(String? argLastName) {
    final String lastName = argLastName!;
    emit(state.copywith(lastName: lastName));
  }

  void setDateOfBirth(String? argDateOfBirth) {
    final String dateOfBirth = argDateOfBirth!;
    emit(state.copywith(dateOfBirth: dateOfBirth));
  }

  void setGender(String? argGender) {
    final String gender = argGender!;
    emit(state.copywith(gender: gender));
  }

  void setReligion(String? argReligion) {
    final String religion = argReligion!;
    emit(state.copywith(religion: religion));
  }

  void setEducationLevel(String? argEducationLevel) {
    final String educationLevel = argEducationLevel!;
    emit(state.copywith(educationLevel: educationLevel));
  }

  void setEthnicity(String? argEthnicity) {
    final String ethnicity = argEthnicity!;
    emit(state.copywith(ethnicity: ethnicity));
  }

  void setPhoneNumber(String? argPhoneNumber) {
    final String phoneNumber = argPhoneNumber!;
    emit(state.copywith(phoneNumber: phoneNumber));
  }

  void setEmail(String? argEmail) {
    final String email = argEmail!;
    emit(state.copywith(email: email));
  }

  void setAddressLine1(String? argAddressLine1) {
    final String addressLine1 = argAddressLine1!;
    emit(state.copywith(addressLine1: addressLine1));
  }

  void setAddressLine2(String? argAddressLine2) {
    final String addressLine2 = argAddressLine2!;
    emit(state.copywith(addressLine2: addressLine2));
  }

  void setAddressLine3(String? argAddressLine3) {
    final String addressLine2 = argAddressLine3!;
    emit(state.copywith(addressLine3: addressLine2));
  }

  void setAddressLine4(String? argAddressLine4) {
    final String addressLine4 = argAddressLine4!;
    emit(state.copywith(addressLine4: addressLine4));
  }

  void setCountryCode(String? argCountryCode) {
    final String? countryCode = argCountryCode!;
    emit(state.copywith(countryCode: countryCode));
  }

  void setCity(String? argCity) {
    final String? city = argCity!;
    emit(state.copywith(city: city));
  }

  void setEmergencyContactName(String? argContactName) {
    final String? contactName = argContactName!;
    emit(state.copywith(emergencyContactName: contactName));
  }

  void setEmergencyContactPhoneNumber(String? argPhoneNumber) {
    final String? contactPhoneNumber = argPhoneNumber!;
    emit(state.copywith(emergencyContactPhoneNumber: contactPhoneNumber));
  }

  void setEmergencyContactRelationship(String? argRelationship) {
    final String? contactRelationship = argRelationship!;
    emit(state.copywith(emergencyContactRelationship: contactRelationship));
  }

  void setContactPreference(String? argContactPreference) {
    final String contactPreference = argContactPreference!;
    emit(state.copywith(contactPreferences: contactPreference));
  }

  void setZipCode(String? argZipcode) {
    final String zipcode = argZipcode!;
    emit(state.copywith(zipCode: zipcode));
  }

  Future<Response?> createNewPatient({String? token}) async {
    Response? response = await _registrationRepositories.createNewPatient(
        token: token,
        firstName: state.firstName,
        middleName: state.middleName,
        lastName: state.lastName,
        phoneNumber: state.phoneNumber,
        gender: state.gender,
        religion: state.religion,
        educationLevel: state.educationLevel,
        contactPreference: state.contactPreferences,
        addressLine1: state.addressLine1,
        zipCode: state.zipCode,
        city: state.city,
        email: state.email,
        ethnicity: state.ethnicity,
        emergencyContactName: state.emergencyContactName,
        emergencyContactPhoneNumber: state.emergencyContactPhoneNumber,
        emergencyContactRelationship: state.emergencyContactRelationship,
        addressLine2: state.addressLine2,
        dateOfBirth: state.dateOfBirth,
        countryCode: state.countryCode);

    return response;
  }

  void clearState() {
    emit(const PatientState(
        dateOfBirth: "",
        educationLevel: "",
        gender: "",
        religion: "",
        ethnicity: ""));
  }
}

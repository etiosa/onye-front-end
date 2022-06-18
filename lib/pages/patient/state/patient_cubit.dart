import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/patient/repository/patient_repository.dart';
import 'package:onye_front_ened/system/analytics/patient_analytics.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepositories _patientRepositories;

  PatientCubit(this._patientRepositories)
      : super(const PatientState(
          dateOfBirth: '',
          gender: '',
          religion: '',
          educationLevel: '',
          ethnicity: '',
        ));
  final PatientAnalytics _patientAnalytics = PatientAnalytics();
  final AuthRepository _authRepository = AuthRepository();
  late final LoginBloc _loginbloc = LoginBloc(_authRepository);
  void setSearchQuery(String? query) {
    final String searchQuery = query!;
    emit(state.copyWith(query: searchQuery));
  }

  void fetchPatient({required String token, required String patientId}) async {

    emit(state.copyWith(fetchpatientstate: FETCHPATIENTSTATE.inprogress));
    try {
      Response? response = await _patientRepositories.fetchPatient(
          patientId: patientId, token: token);
      int statusCode = response!.statusCode;
      var body = json.decode(response.body);

      if (statusCode == 200) {
        //TODO:USE MODEL FOR THIS
        emit(state.copyWith(
            fetchpatientstate: FETCHPATIENTSTATE.fetch,
            firstName: body['firstName'] ,
            lastName: body['lastName'] ,
            middleName: body['middleName'] ,
            dateOfBirth: body['dateOfBirth'],
            gender: body['gender'],
            religion: body['religion'],
            ethnicity: body['ethnicity'],
            educationLevel: body['educationLevel'],
            phoneNumber: body['phoneNumber'],
            addressLine1: body['address']['line1'],
            zipCode: body['address']['zipCode'],
            city: body['address']['city'],
            email: body['email'],
            contactPreferences: body['contactPreference'],
            emergencyContactName: body['emergencyContact']['name'] ,
            emergencyContactPhoneNumber: body['emergencyContact']
                ['phoneNumber'],
            emergencyContactRelationship: body['emergencyContact']
                ['relationship']));
      }
    } catch (err) {
      emit(state.copyWith(fetchpatientstate: FETCHPATIENTSTATE.error));
    }
  }

  void editPatient({required String token, required String patientId}) async {
    String? dateOfBirth;
    if (state.dateOfBirth != null && state.dateOfBirth!.isEmpty) {
      dateOfBirth = null;
    } else {
      dateOfBirth = state.dateOfBirth;
    }
    emit(state.copyWith(patienteditstate: PATIENTEDITSTATE.inprogress));

    try {
      Response? response = await _patientRepositories.editPatientData(
          patientId: patientId,
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
          emergencyContactPhoneNumber:
              state.emergencyContactPhoneNumber?.trim(),
          emergencyContactRelationship:
              state.emergencyContactRelationship?.trim(),
          countryCode: 'NG');

      int statusCode = response!.statusCode;
      var body = json.decode(response.body);

      if (statusCode == 202) {
        _patientAnalytics.editPatient(patiendId: body['id'], time: DateTime.now().toIso8601String(),    userId: _loginbloc.state.userId,
            userType: _loginbloc.state.userType  );
        emit(state.copyWith(
            patienteditstate: PATIENTEDITSTATE.save,
            firstName: body['firstName'],
            lastName: body['lastName'],
            middleName: body['middleName'],
            dateOfBirth: body['dateOfBirth'],
            gender: body['gender'],
            religion: body['religion'],
            ethnicity: body['ethnicity'],
            educationLevel: body['educationLevel'],
            phoneNumber: body['phoneNumber'],
            addressLine1: body['address']['line1'],
            zipCode: body['address']['zipCode'],
            city: body['address']['city'],
            email: body['email'],
            contactPreferences: body['contactPreference'],
            emergencyContactName: body['emergencyContact']['name'],
            emergencyContactPhoneNumber: body['emergencyContact']
                ['phoneNumber'],
            emergencyContactRelationship: body['emergencyContact']
                ['relationship']));
      } else {
        emit(state.copyWith(patienteditstate: PATIENTEDITSTATE.error));
      }
    } catch (err) {
      emit(state.copyWith(patienteditstate: PATIENTEDITSTATE.unknown));
    }
  }

  void resetFecthAndSaveState() {
    emit(state.copyWith(
        fetchpatientstate: FETCHPATIENTSTATE.init,
        patienteditstate: PATIENTEDITSTATE.init));
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

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;

    emit(state.copyWith(searchParams: searchParams));
  }

  Future<Response?> createNewPatient({String? token}) async {
    String? dateOfBirth;
    if (state.dateOfBirth != null && state.dateOfBirth!.isEmpty) {
      dateOfBirth = null;
    } else {
      dateOfBirth = state.dateOfBirth;
    }
    emit(state.copyWith(patientcreation: PATIENTCREATION.inprogress));

    try {
      Response? response = await _patientRepositories.createNewPatient(
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
          emergencyContactPhoneNumber:
              state.emergencyContactPhoneNumber?.trim(),
          emergencyContactRelationship:
              state.emergencyContactRelationship?.trim(),
          countryCode: 'NG');

      int statusCode = response!.statusCode;
      var body = json.decode(response.body);

      if (statusCode == 201) {
        _patientAnalytics.createPatient(
            patientId: body['id'],
            time: DateTime.now().toIso8601String(),
            userId: _loginbloc.state.userId,
            userType: _loginbloc.state.userType);

        emit(state.copyWith(patientcreation: PATIENTCREATION.created));
      } else {
        emit(state.copyWith(patientcreation: PATIENTCREATION.error));
      }
      return response;
    } catch (er) {
      emit(state.copyWith(patientcreation: PATIENTCREATION.unknown));
    }
    return null;
  }

  void resetPatientCreationState() {
    emit(state.copyWith(patientcreation: PATIENTCREATION.init));
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

  void searchPatients({String? query, String? token, int? nextPage}) async {
    var searchResponse = await _patientRepositories.searchPatients(
        searchParams: query, token: token, nextPage: nextPage);
    var body = json.decode(searchResponse!.body);
    var totalPages = body['totalPages'];
    var patientsList = body['elements'];
    emit(state.copyWith(patientsList: patientsList, maxPageNumber: totalPages));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedPatientId: selectedId));
  }

  void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(state.copyWith(nextPage: nextPage));
    if (state.nextPage <= state.maxPageNumber) {
      //call search
      var searchResponse = await _patientRepositories.searchPatients(
          token: token, searchParams: searchParams, nextPage: state.nextPage);
      var body = json.decode(searchResponse!.body);
      var patientsList = body['elements'];
      emit(state.copyWith(patientsList: patientsList));
    }
  }
}

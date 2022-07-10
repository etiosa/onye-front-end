import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:onye_front_ened/components/repository/clinical_note_repository.dart';

part 'clinical_note_state.dart';

class ClinicalnoteCubit extends Cubit<ClinicalnoteState> {
  final ClinicalNoteRepository _clinicalNoteRepository;

  ClinicalnoteCubit(this._clinicalNoteRepository)
      : super(const ClinicalnoteState());

  void setpatientId(String patientId) {}
  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(medicalId: selectedId));
  }

  void setPatientId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(patientId: selectedId));
  }

  void setClinicalNote(String? note) {
    final String clinicalNote = note!;
    emit(state.copyWith(text: clinicalNote));
  }

  void setClinicalNoteTitle(String? title) {
    final String clinicalNoteTitle = title!;
    emit(state.copyWith(title: clinicalNoteTitle));
  }

  void setClinicalNoteType(String? type) {
    final String clinicalNoteType = type!;
    emit(state.copyWith(type: clinicalNoteType));
  }

  void setMedicalPersonnelId(String medicalPersonnelId) {}

  Future<Response?> createClinicalNote(
      {String? token,
      String? patientId,
      String? medicalId,
      String? title,
      String? note,
      String? registrationId,
      String? clinicalNoteType}) async {
    Response? req = await _clinicalNoteRepository.createClinicalNote(
        token: token,
        patientId: patientId,
        medicalId: medicalId,
        note: note,
        registerationId: registrationId,
        clincialNoteType: clinicalNoteType,
        title: title);

    return req;
  }

  Future<Response?> getPatientClinicalNote({
    String? token,
    String? id,
  }) async {
    //print("getPatientClinical Note");
    //print(token);
    print("get patient clinical note");
    print(token);

    emit(state.copyWith(loadclinicalnote: LOADCLINICALNOTE.loading));

    try {
      Response? req = await _clinicalNoteRepository.getPatientClinicalNote(
          token: token, id: id);

      if (req?.statusCode == 200) {
        setPatientClinicalNote(req!);
        return req;
      }
    } catch (err) {
      emit(state.copyWith(loadclinicalnote: LOADCLINICALNOTE.error));
    }
    return null;
  }

  void setPatientClinicalNote(Response req) async {
    final body = jsonDecode(req.body);

    emit(state.copyWith(
        loadclinicalnote: LOADCLINICALNOTE.loaded,
        text: body['text'],
        title: body['title'],
        type: body['type']));
  }

  void setclinicalNoteID(String clinicalNoteId) {
    emit(state.copyWith(clinicalNoteId: clinicalNoteId));
  }

  Future<Response?> updateClinicalNote({
    String? id,
    String? type,
    String? title,
    String? noteText,
    String? token,
  }) async {
    Response? response = await _clinicalNoteRepository.updateClinicalNote(
      id: id,
      type: type,
      noteText: noteText,
      title: title,
      token: token,
    );

    return response;
  }

  void clearClinicalNoteState() {
    emit(const ClinicalnoteState());
  }

  clearState() {
    emit(const ClinicalnoteState());
  }
}



//getting the data from the backend 
//is json 
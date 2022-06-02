// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicalNoteModel _$ClinicalNoteModelFromJson(Map<String, dynamic> json) =>
    ClinicalNoteModel(
      medicalPersonnelId: json['medicalPersonnelId'] as String,
      patientId: json['patientId'] as String,
      text: json['text'] as String,
      title: json['title'] as String,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ClinicalNoteModelToJson(ClinicalNoteModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'patientId': instance.patientId,
      'medicalPersonnelId': instance.medicalPersonnelId,
      'title': instance.title,
      'text': instance.text,
    };

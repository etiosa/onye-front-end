// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String,
      dateofBirth: json['dateofBirth'] as String,
      religion: json['religion'] as String,
      ethnicity: json['ethnicity'] as String,
      gender: json['gender'] as String,
      educationLevel: json['educationLevel'] as String,
      phoneNumbr: json['phoneNumbr'] as String,
      contactPreference: json['contactPreference'] as String,
      countryCode: json['countryCode'] as String,
      aliveStatus: json['aliveStatus'] as String,
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'dateofBirth': instance.dateofBirth,
      'religion': instance.religion,
      'ethnicity': instance.ethnicity,
      'gender': instance.gender,
      'educationLevel': instance.educationLevel,
      'phoneNumbr': instance.phoneNumbr,
      'contactPreference': instance.contactPreference,
      'countryCode': instance.countryCode,
      'aliveStatus': instance.aliveStatus,
    };

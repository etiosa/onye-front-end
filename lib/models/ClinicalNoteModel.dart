
// ignore: file_names
import 'package:json_annotation/json_annotation.dart';

part 'ClinicalNoteModel.g.dart';


///[response]
///** ssss */
@JsonSerializable()
class ClinicalNoteModel {
  final String? type;
  final String patientId;
  final String medicalPersonnelId;
  final String title;
  final String text;

  const ClinicalNoteModel(
      {required this.medicalPersonnelId,
      required this.patientId,
      required this.text,
      required this.title,
       this.type});

  factory ClinicalNoteModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicalNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicalNoteModelToJson(this);
}


//request

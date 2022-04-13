
import 'package:json_annotation/json_annotation.dart';
part 'PatientModel.g.dart';


@JsonSerializable()
class PatientModel {
  String firstName;
  String lastName;
  String middleName;
  String dateofBirth;
  String religion;
  String ethnicity;
  String gender;
  String educationLevel;
  String phoneNumbr;
  String contactPreference;
  String countryCode;
  String aliveStatus;
 
  PatientModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateofBirth,
    required this.religion,
    required this.ethnicity,
    required this.gender,
    required this.educationLevel,
    required this.phoneNumbr,
    required this.contactPreference,
    required this.countryCode,
    required this.aliveStatus,
  });
}









/* {
  "nin": "string",
  "firstName": "string",
  "middleName": "string",
  "lastName": "string",
  "dateOfBirth": "2022-04-02",
  "gender": "MALE",
  "religion": "HINDUISM",
  "ethnicity": "HAUSA",
  "insuranceInformation": {
    "number": "string",
    "name": "string"
  },
  "educationLevel": "NONE",
  "phoneNumber": "string",
  "address": {
    "line1": "string",
    "line2": "string",
    "line3": "string",
    "line4": "string",
    "zipCode": "string",
    "city": "string",
    "countryCode": "UNDEFINED"
  },
  "email": "string",
  "contactPreference": "PHONE",
  "countryCode": "UNDEFINED",
  "aliveStatus": {
    "deceased": true,
    "timeOfDeath": "2022-04-02T16:07:42.722Z",
    "causeOfDeath": "string"
  },
  "emergencyContact": {
    "name": "string",
    "phoneNumber": "string",
    "relationship": "string"
  }
} */
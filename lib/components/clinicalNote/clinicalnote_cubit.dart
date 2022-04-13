import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onye_front_ened/models/ClinicalNoteModel.dart';

part 'clinicalnote_state.dart';

class ClinicalnoteCubit extends Cubit<ClinicalnoteState> {
  //ClinicalnoteCubit(ClinicalnoteState initialState) : super(initialState);

 // ClinicalnoteCubit(ClinicalnoteState initialState) : super(initialState);


  ClinicalnoteCubit() : super(const ClinicalnoteState());
  


void setType(String type) {
}

void setText(String text){}


void setpatientId(String patientId){}


void settitle(String title){}

void setMedicalPersonnelId(String medicalPersonnelId){}

}


//getting the data from the backend 
//is json 
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/doctor_repository.dart';

part 'doctor_cubit_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit(this._doctorRepository) : super(const DoctorState());
  final DoctorRepository _doctorRepository;

  void setNextPage({int? nextPage, String? token, String? searchParams}) async {
    emit(state.copyWith(nextPage: nextPage));
    if (state.nextPage <= state.maxDoctorPageNumber) {
      var searchReponse = await _doctorRepository.searchDoctors(
          token: token, searchParams: searchParams, nextPage: nextPage);

      var body = json.decode(searchReponse!.body);
      var doctorLIst = body['elements'];
      emit(state.copyWith(doctorsList: doctorLIst));
    }
  }

  void setSearchParams(String? argSearchParams) {
    final String searchParams = argSearchParams!;

    emit(state.copyWith(searchParams: searchParams));
  }



  void searchDoctors({String? query, String? token, int? nextPage}) async {
    emit(state.copyWith(doctorsearchstate: DOCTORSEARCHSTATE.inital));
    var doctors = await _doctorRepository.searchDoctors(
        searchParams: query, token: token, nextPage: nextPage);
    var doctorReponse = json.decode(doctors!.body);
    var doctorLists = doctorReponse['elements'];
    var totalPages = doctorReponse['totalPages'];

//    var body = json.decode(searchResponse!.body);

     if (doctorLists.isNotEmpty) {
      emit(state.copyWith(
          doctorsList: doctorLists,
          doctorsearchstate: DOCTORSEARCHSTATE.sucessful,
          maxDoctorPageNumber: totalPages,
          
          ));
    }
    if (doctorLists.isEmpty) {
      emit(state.copyWith(
          doctorsList: doctorLists,
          doctorsearchstate: DOCTORSEARCHSTATE.notFound));
    }
   
  
  }


  void setSelectedMedicalPersonnelId(String? argSelectedId) {
    final String selectedId = argSelectedId!;
    emit(state.copyWith(selectedMedicalPersonnelId: selectedId));
  }

}

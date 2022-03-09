import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onye_front_ened/pages/patient/repository/dropDownRepositories.dart';

part 'formdropdown_state.dart';

class FormdropdownCubit extends Cubit<FormdropdownState> {
  final DropDownRepositories _downRepositories;

  FormdropdownCubit(this._downRepositories) : super(const FormdropdownState());

  void getDropDown() async {
    final dropDown = await _downRepositories.getFormDropDown();
    emit(state.copyWith(educationLevel: dropDown['educationLevel']));
    emit(state);
  }

  void educationDropDown() async {
    final dropDown = await _downRepositories.getFormDropDown();
    emit(state.copyWith(educationLevel: dropDown['educationLevel']));
  }

  void genderDropDown() async {
    final dropDown = await _downRepositories.getFormDropDown();
    emit(state.copyWith(gender: dropDown['gender']));
  }

  void religionDropDown() async {
    final dropDown = await _downRepositories.getFormDropDown();
    emit(state.copyWith(religion: dropDown['religion']));
  }

  void ethnicityDropDown() async {
    final dropDown = await _downRepositories.getFormDropDown();
    emit(state.copyWith(ethnicity: dropDown['ethnicity']));
  }
}

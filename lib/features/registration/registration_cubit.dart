import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(const RegistrationState());

  void setFirstName(String? argFirstName) {
    final String firstName = argFirstName!;
    emit(state.copywith(firstName: firstName));
  }

  void setLastName(String? argLastName) {
    final String lastName = argLastName!;
    emit(state.copywith(lastName: lastName));
  }

  void setDateofBirth(String? argDateOfBirth) {
    final String dateOfBirth = argDateOfBirth!;
    emit(state.copywith(dateOfBirth: dateOfBirth));
  }

  void setEducationLevel(String? argEducationLevel) {
    final String educationLevel = argEducationLevel!;
    emit(state.copywith(educationLevel: educationLevel));
  }

  void setGender(String? argGender) {
    final String gender = argGender!;
    emit(state.copywith(gender: gender));
  }

  void setReligion(String? argReligion) {
    final String religion = argReligion!;
    emit(state.copywith(religion: religion));
  }
}

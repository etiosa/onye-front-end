import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shcedule_state.dart';

enum RegistrationFormState { init, fail, scuessful }


class ShceduleCubit extends Cubit<ShceduleState> {
  ShceduleCubit() : super(ShceduleInitial());
}

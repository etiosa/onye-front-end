import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedule_state.dart';

enum RegistrationFormState { init, fail, successful }


class ScheduleCubit extends Cubit<ShceduleState> {
  ScheduleCubit() : super(ShceduleInitial());
}

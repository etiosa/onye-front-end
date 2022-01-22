import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_cubit_state.dart';

class SignupCubitCubit extends Cubit<SignupCubitState> {
  SignupCubitCubit() : super(SignupCubitInitial());
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shcedule_state.dart';

class ShceduleCubit extends Cubit<ShceduleState> {
  ShceduleCubit() : super(ShceduleInitial());
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'eula_event.dart';
part 'eula_state.dart';

class EulaBloc extends Bloc<EulaEvent, EulaState> {
  EulaBloc() : super(const EulaState()) { // init will load first
    on<EulaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

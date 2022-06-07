import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appstate_event.dart';
part 'appstate_state.dart';

class AppstateBloc extends Bloc<AppstateEvent, AppstateState> {
  AppstateBloc() : super(AppstateInitial()) {
    on<AppstateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}




// call home and get if the token is expire
//if not
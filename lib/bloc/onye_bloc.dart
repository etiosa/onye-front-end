import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onye_event.dart';
part 'onye_state.dart';

class OnyeBloc extends Bloc<OnyeEvent, OnyeState> {
  OnyeBloc() : super(OnyeInitial()) {
    on<FetchDatas>((event, emit) {
      emit(OnyeLoaded());
      // TODO: implement event handler
    });
  }
}

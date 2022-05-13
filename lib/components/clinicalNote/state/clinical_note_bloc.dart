import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'clinical_note_event.dart';
part 'clinical_note_state.dart';

class ClinicalNoteBloc extends Bloc<ClinicalNoteEvent, ClinicalNoteState> {
  ClinicalNoteBloc() : super(const ClinicalNoteState()) {
    on<ClinicalNoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

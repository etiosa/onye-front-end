part of 'clinical_note_bloc.dart';

abstract class ClinicalNoteEvent extends Equatable {
  const ClinicalNoteEvent();

  @override
  List<Object> get props => [];
}

class ClinicalNoteInit extends ClinicalNoteEvent {}

class ClinicalNoteLoading extends ClinicalNoteEvent {}

class ClinicalNoteLoadingError extends ClinicalNoteEvent {
  final String errorMessage;

  const ClinicalNoteLoadingError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ClinicalNoteLoaded extends ClinicalNoteEvent {
  final Response clinicalNoteBody;

  const ClinicalNoteLoaded(this.clinicalNoteBody);
  @override
  List<Object> get props => [clinicalNoteBody];

}



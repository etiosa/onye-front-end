part of './doctor_cubit_cubit.dart';

enum DOCTORSEARCHSTATE { inital, sucessful, inprogress, failed, notFound }

class DoctorState extends Equatable {
  const DoctorState(
      {this.nextPage = 0,
      this.doctorsearchstate = DOCTORSEARCHSTATE.inital,
      this.doctorsList = const [],
      this.maxDoctorPageNumber = 0,
      this.searchParams = '',
      this.selectedMedicalPersonnelId = ''});

  final int nextPage;
  final List<dynamic> doctorsList;
  final String selectedMedicalPersonnelId;
  final DOCTORSEARCHSTATE doctorsearchstate;
  final int maxDoctorPageNumber;
  final String searchParams;

  @override
  List<Object> get props => [
        nextPage,
        doctorsList,
        selectedMedicalPersonnelId,
        doctorsearchstate,
        maxDoctorPageNumber,
        searchParams
      ];

  DoctorState copyWith(
      {int? nextPage,
      String? selectedMedicalPersonnelId,
      DOCTORSEARCHSTATE? doctorsearchstate,
      List<dynamic>? doctorsList,
      String? searchParams,
      int? maxDoctorPageNumber}) {
    return DoctorState(
        maxDoctorPageNumber: maxDoctorPageNumber ?? this.maxDoctorPageNumber,
        nextPage: nextPage ?? this.nextPage,
        selectedMedicalPersonnelId:
            selectedMedicalPersonnelId ?? this.selectedMedicalPersonnelId,
        doctorsList: doctorsList ?? this.doctorsList,
        searchParams: searchParams??this.searchParams,
        doctorsearchstate: doctorsearchstate ?? this.doctorsearchstate);
  }
}

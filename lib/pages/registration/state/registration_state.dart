part of 'registration_cubit.dart';


enum REGISTRATIONSTATE { inita, sucessful, inprogress, failed }

class RegistrationState extends Equatable {

    final List<dynamic> registrationList;
    final String typeOfVisit;
    final String reasonForVisit;
    final int selectedPatientIndex;

  const RegistrationState(this.registrationList, this.typeOfVisit, this.reasonForVisit, this.selectedPatientIndex);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

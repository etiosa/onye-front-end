
class PatientFormValidator {

  String? firstNameError;
  String? lastNameError;
  String? genderError;
  String? phoneNumberError;
  String? emailError;

  void clearErrors() {
    firstNameError = null;
    lastNameError = null;
    genderError = null;
    phoneNumberError = null;
    emailError = null;
  }
}

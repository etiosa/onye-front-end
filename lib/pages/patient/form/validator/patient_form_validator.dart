
class PatientFormValidator {

  String? firstNameError;

  void setFirstNameError(String? error) {
    print('setFirstNameError was called');
    print('firstNameError: $firstNameError');
    firstNameError = error;
    print('firstNameError: $firstNameError');
  }

  String? getFirstNameError() {
    print('getFirstNameError was called');
    return firstNameError;
  }

  void clearErrors() {
    firstNameError = null;
  }
}

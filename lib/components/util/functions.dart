
class Functions {
  static String buildFullName(String firstName, String? middleName, String lastName) {
    String fullName;
    if (middleName != null) {
      fullName = firstName + ' ' + middleName + ' ' + lastName;
    } else {
      fullName = firstName + ' ' + lastName;
    }
    return fullName;
  }


  
}

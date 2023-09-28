class RegexValidator {
  /// Email validator ---
  static bool validateEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (regex.hasMatch(email)) ? true : false;
  }

  static bool validatePhoneNumber(String phoneNumber) {
    String pattern = r'^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$';
    // String pattern = r'^((0)?)(3)([0-9]{9})$';
    RegExp regex = RegExp(pattern);
    return (regex.hasMatch(phoneNumber)) ? true : false;
  }
}

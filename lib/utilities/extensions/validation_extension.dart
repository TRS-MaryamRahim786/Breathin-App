///Extension for Validation
extension StringValidation on String {
  static final RegExp defaultEmailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$",
  );

  /// Phone Phone
  static final RegExp _defaultPhoneRegExp = RegExp(r'^\d{7,15}$');

  /// Password RegExp
  static final RegExp _defaultPasswordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  /// Username RegExp
  static final RegExp _defaultUsernameRegExp = RegExp(
    r'^[a-zA-Z0-9_]{3,15}$',
  );

  ///Text RegExp
  static final RegExp _defaultTextRegExp = RegExp(
    r'^[a-zA-Z0-9_\-=@,.:; ]+$',
  );

  /// Validation for email
  bool isValidEmail() {
    return defaultEmailRegExp.hasMatch(this);
  }

  /// Validation for phone number
  bool isValidPhoneNumber() {
    return _defaultPhoneRegExp.hasMatch(this);
  }

  /// Validation for password
  bool isValidPassword() {
    return _defaultPasswordRegExp.hasMatch(this);
  }

  /// Validation for username
  bool isValidUsername() {
    return _defaultUsernameRegExp.hasMatch(this);
  }

  /// Validation for normal text
  bool isValidText() {
    return _defaultTextRegExp.hasMatch(this);
  }
}

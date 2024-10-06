/// ======= [Validations]

String? isValidEmail(String? email) {
  // Regular expression pattern for email validation
  final RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
  if (email == null || email.isEmpty) {
    return '\u26A0 Email is required.';
  } else if (!(emailRegex.hasMatch(email))) {
    return '\u26A0 Enter valid email.';
  } else {
    return null;
  }
}

String? isValidPassword(String? password) {
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{5,}$');
  if (password == null || password.isEmpty) {
    return '\u26A0 Password is required.';
  } else if (!(password.length >= 8)) {
    return '\u26A0 Password must be 8 characters long.';
  }
  // else if (!(passwordRegex.hasMatch(password))) {
  //   return '\u26A0Enter Strong Password';
  // }
  else {
    return null;
  }
}

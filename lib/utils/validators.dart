/// A module to contain the common validation logic in textformfields;
/// also acts as redirection layer to change all the call logic in one place if
/// uses a package at a later date

String? isShort(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required Field';
  }
  if (value.length < 3) {
    return 'Too short';
  }
  return null;
}

String? isEmail(String? email) {
  return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email!)
      ? null
      : 'Invalid Email';
}

String? isInt(String? value) {
  int intval;

  if (value == null || value.isEmpty) {
    return 'Required Field';
  }
  try {
    intval = int.parse(value);
  } on FormatException {
    return 'Non-number character input';
  }
  if (intval < 1) {
    return 'Zero or negative not allowed';
  }
  return null;
}

String? isPhone(String? number) {
  return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(number!)
      ? null
      : 'Invalid Phone Number';
}

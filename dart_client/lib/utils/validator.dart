bool validateSsn(String? ssn) {
  if (ssn == null) {
    return false;
  }
  RegExp passwordRegExp =
      RegExp(r'^(((19|20)?(\d{6}(-|\s)\d{4}))|((19|20)?\d{10}))$');

  return passwordRegExp.hasMatch(ssn);
}

bool validateRegNo(String? regNo) {
  if (regNo == null) {
    return false;
  }
  RegExp passwordRegExp = RegExp(r'^([a-zA-Z]{3}[0-9]{2}[a-zA-Z0-9]{1})$');

  return passwordRegExp.hasMatch(regNo);
}

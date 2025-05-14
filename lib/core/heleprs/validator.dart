String? valdiator({
  required String? input,
  required String label,
  required bool isRequired,
  int? minChars,
  int? maxChars,
  bool isEmail = false,
  bool isConfirmPassword = false,
  String? firstPassword,
}) {
  input = input ?? '';
  if (isRequired && (input.isEmpty)) {
    return '$label is required';
  }
  if (minChars != null && input.length < minChars) {
    return "$label can't be less than $minChars characters ";
  }
  if (maxChars != null && input.length > maxChars) {
    return "$label can't be more than $maxChars characters ";
  }
  if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input)) {
    return "Email address not valid";
  }
  if (isConfirmPassword && input != firstPassword) {
    return "Confirm Password Don't match the Password";
  }
  return null;
}

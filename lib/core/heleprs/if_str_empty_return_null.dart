String? ifStrEmptyReturnNull(String? value) {
  if (value == null || value == '') {
    return null;
  }
  return value;
}

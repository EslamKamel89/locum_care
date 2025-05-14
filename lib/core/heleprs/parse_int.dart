import 'package:locum_care/core/heleprs/print_helper.dart';

int? parseInt(String? numberStr) {
  if (numberStr == null) return null;
  try {
    int number = int.parse(numberStr);
    return number;
  } catch (e) {
    pr('Exception occured while parsing int: $e');
    return null;
  }
}

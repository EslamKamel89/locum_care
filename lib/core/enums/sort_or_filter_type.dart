import 'package:locum_care/core/enums/filter_option_enum.dart';
import 'package:locum_care/core/enums/sort_options_enum.dart';

sealed class SortOrFilterType {}

class SortType extends SortOrFilterType {
  SortOptionsEnum value;
  SortType(this.value);
}

class FilterType extends SortOrFilterType {
  FilterOptionsEnum value;
  FilterType(this.value);
}

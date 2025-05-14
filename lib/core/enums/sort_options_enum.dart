enum SortOptionsEnum {
  published,
  salary,
}

extension SortOptionsEnumExtension on SortOptionsEnum {
  String toShortString() {
    switch (this) {
      case SortOptionsEnum.published:
        return 'Published';
      case SortOptionsEnum.salary:
        return 'Salary';
    }
  }

  String toFullString() {
    switch (this) {
      case SortOptionsEnum.published:
        return 'Show the latest jobs first';
      case SortOptionsEnum.salary:
        return 'Show the most paying jobs first';
    }
  }
}

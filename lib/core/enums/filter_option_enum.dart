// ignore_for_file: public_member_api_docs, sort_constructors_first

enum FilterOptionsEnum {
  specialty,
  jobTitle,
  jobType,
  state,
  languages,
  // skills,
  address,
  distance,
}

extension FilterOptionsEnumExtension on FilterOptionsEnum {
  String toShortString() {
    switch (this) {
      case FilterOptionsEnum.specialty:
        return 'Specialty';
      case FilterOptionsEnum.jobTitle:
        return 'Job Title';
      case FilterOptionsEnum.jobType:
        return 'job Type';
      case FilterOptionsEnum.state:
        return 'State';
      case FilterOptionsEnum.languages:
        return 'Languages';
      // case FilterOptionsEnum.skills:
      // return 'Skills';
      case FilterOptionsEnum.address:
        return 'Address';
      case FilterOptionsEnum.distance:
        return 'Distance';
    }
  }
}

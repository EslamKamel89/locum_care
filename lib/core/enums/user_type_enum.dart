enum UserTypeEnum {
  doctor,
  hospital,
}

extension UserTypeEnumExtension on UserTypeEnum {
  String toShortString() {
    switch (this) {
      case UserTypeEnum.doctor:
        return 'doctor';
      case UserTypeEnum.hospital:
        return 'hospital';
    }
  }

  String toFullString() {
    switch (this) {
      case UserTypeEnum.hospital:
        return 'Healthcare Service Provider';
      case UserTypeEnum.doctor:
        return 'healthcare professional';
    }
  }
}

enum UserType {
  hospital,
  doctor;

  static UserType fromStr(String userType) {
    return userType == 'doctor' ? UserType.doctor : UserType.hospital;
  }

  @override
  String toString() {
    return this == UserType.doctor ? 'doctor' : 'hospital';
  }
}

class UserEntity {
  int? id;
  String? name;
  String? email;
  int? stateId;
  int? districtId;
  String? token;
  UserType? userType;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.stateId,
    this.districtId,
    this.token,
    this.userType,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email,  stateId: $stateId, districtId: $districtId, token: $token , userType: $userType)';
  }
}

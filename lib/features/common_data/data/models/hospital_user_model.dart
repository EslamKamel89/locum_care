import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/common_data/data/models/district_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';

class HospitalUserModel extends UserModel {
  UserType? type;
  DistrictModel? district;
  StateModel? state;
  HospitalModel? hospital;

  HospitalUserModel({
    super.id,
    super.name,
    super.email,
    super.stateId,
    super.districtId,
    super.userTypeStr,
    super.authId,
    super.authType,
    super.fcmToken,
    this.type,
    this.district,
    this.state,
    this.hospital,
  });

  @override
  String toString() {
    return 'HospitalUserModel(id: $id, name: $name, email: $email, authId: $authId, authType: $authType , fcmToken: $fcmToken, stateId: $stateId, districtId: $districtId, type: $type, district: $district, state: $state, hospital: $hospital)';
  }

  factory HospitalUserModel.fromJson(Map<String, dynamic> json) {
    return HospitalUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      stateId: json['state_id'] as int?,
      districtId: json['district_id'] as int?,
      type: json['type'] == null ? null : UserType.fromStr(json['type']),
      userTypeStr: json['type'] as String,
      district: json['district'] == null ? null : DistrictModel.fromJson(json['district']),
      state: json['state'] == null ? null : StateModel.fromJson(json['state']),
      hospital: json['hospital'] == null ? null : HospitalModel.fromJson(json['hospital']),
      authId: json['auth_id'] as String?,
      authType: json['auth_type'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );
  }
}

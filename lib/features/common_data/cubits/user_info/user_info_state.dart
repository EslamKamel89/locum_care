// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_info_cubit.dart';

class UserInfoState {
  UserType? userType;
  DoctorUserModel? doctorUserModel;
  HospitalUserModel? hospitalUserModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  UserInfoState({
    this.userType,
    this.doctorUserModel,
    this.hospitalUserModel,
    this.errorMessage,
    this.responseType,
  });

  UserInfoState copyWith({
    UserType? userType,
    DoctorUserModel? doctorUserModel,
    HospitalUserModel? hospitalUserModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return UserInfoState(
      userType: userType ?? this.userType,
      doctorUserModel: doctorUserModel ?? this.doctorUserModel,
      hospitalUserModel: hospitalUserModel ?? this.hospitalUserModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() {
    return 'UserInfoState(userType: $userType, doctorUserModel: $doctorUserModel, hospitalUserModel: $hospitalUserModel, errorMessage: $errorMessage, responseType: $responseType)';
  }
}

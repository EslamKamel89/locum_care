// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_update_cubit.dart';

class UserUpdateState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  UserDoctorParams? doctorInfoParams;
  UserModel? userModel;
  UserUpdateState({
    this.errorMessage,
    this.responseType,
    this.doctorInfoParams,
    this.userModel,
  });

  UserUpdateState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    UserDoctorParams? doctorInfoParams,
    UserModel? userModel,
  }) {
    return UserUpdateState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      doctorInfoParams: doctorInfoParams ?? this.doctorInfoParams,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  String toString() {
    return 'UserDoctorState(errorMessage: $errorMessage, responseType: $responseType, doctorInfoParams: $doctorInfoParams, userModel: $userModel)';
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'view_hospital_profile_cubit.dart';

class ViewHospitalProfileState {
  HospitalUserModel? hospitalUserModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  ViewHospitalProfileState({
    this.hospitalUserModel,
    this.errorMessage,
    this.responseType,
  });

  ViewHospitalProfileState copyWith({
    HospitalUserModel? hospitalUserModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return ViewHospitalProfileState(
      hospitalUserModel: hospitalUserModel ?? this.hospitalUserModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'ViewHospitalProfileState(hospitalUserModel: $hospitalUserModel, errorMessage: $errorMessage, responseType: $responseType)';
}

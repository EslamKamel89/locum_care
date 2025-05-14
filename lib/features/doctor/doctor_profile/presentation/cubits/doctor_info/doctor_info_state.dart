// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doctor_info_cubit.dart';

class DoctorInfoState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  DoctorInfoParams? doctorInfoParams;
  DoctorInfoModel? doctorInfoModel;
  DoctorInfoState({
    this.errorMessage,
    this.responseType,
    this.doctorInfoParams,
    this.doctorInfoModel,
  });

  DoctorInfoState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    DoctorInfoParams? doctorInfoParams,
    DoctorInfoModel? doctorInfoModel,
  }) {
    return DoctorInfoState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      doctorInfoParams: doctorInfoParams ?? this.doctorInfoParams,
      doctorInfoModel: doctorInfoModel ?? this.doctorInfoModel,
    );
  }

  @override
  String toString() {
    return 'DoctorInfoState(errorMessage: $errorMessage, responseType: $responseType, doctorInfoParams: $doctorInfoParams, doctorInfoModel: $doctorInfoModel)';
  }
}

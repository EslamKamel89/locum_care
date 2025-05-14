// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_info_cubit.dart';

class HospitalInfoState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  HospitalInfoParams? hospitalInfoParams;
  HospitalInfoModel? hospitalInfoModel;
  HospitalInfoState({
    this.errorMessage,
    this.responseType,
    this.hospitalInfoParams,
    this.hospitalInfoModel,
  });

  HospitalInfoState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    HospitalInfoParams? hospitalInfoParams,
    HospitalInfoModel? hospitalInfoModel,
  }) {
    return HospitalInfoState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      hospitalInfoParams: hospitalInfoParams ?? this.hospitalInfoParams,
      hospitalInfoModel: hospitalInfoModel ?? this.hospitalInfoModel,
    );
  }

  @override
  String toString() {
    return 'HospitalInfoState(errorMessage: $errorMessage, responseType: $responseType, hospitalInfoParams: $hospitalInfoParams, hospitalInfoModel: $hospitalInfoModel)';
  }
}

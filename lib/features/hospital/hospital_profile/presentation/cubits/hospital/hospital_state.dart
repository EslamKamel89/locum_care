// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_cubit.dart';

class HospitalState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  HospitalParams? hospitalParams;
  HospitalModel? hospitalModel;
  HospitalState({
    this.errorMessage,
    this.responseType,
    this.hospitalParams,
    this.hospitalModel,
  });

  HospitalState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    HospitalParams? hospitalParams,
    HospitalModel? hospitalModel,
  }) {
    return HospitalState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      hospitalParams: hospitalParams ?? this.hospitalParams,
      hospitalModel: hospitalModel ?? this.hospitalModel,
    );
  }

  @override
  String toString() {
    return 'HospitalState(errorMessage: $errorMessage, responseType: $responseType, hospitalParams: $hospitalParams, hospitalModel: $hospitalModel)';
  }
}

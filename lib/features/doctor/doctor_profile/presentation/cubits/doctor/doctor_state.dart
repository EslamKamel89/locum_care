// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doctor_cubit.dart';

class DoctorState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  DoctorParams? doctorParams;
  DoctorModel? doctorModel;
  DoctorState({
    this.errorMessage,
    this.responseType,
    this.doctorParams,
    this.doctorModel,
  });

  DoctorState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    DoctorParams? doctorParams,
    DoctorModel? doctorModel,
  }) {
    return DoctorState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      doctorParams: doctorParams ?? this.doctorParams,
      doctorModel: doctorModel ?? this.doctorModel,
    );
  }

  @override
  String toString() {
    return 'DoctorState(errorMessage: $errorMessage, responseType: $responseType, doctorParams: $doctorParams, doctorModel: $doctorModel)';
  }
}

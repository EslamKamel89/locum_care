// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'speciality_cubit.dart';

class SpecialtyState {
  List<SpecialtyModel>? specialtyModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  SpecialtyState({
    this.specialtyModels,
    this.errorMessage,
    this.responseType,
  });

  SpecialtyState copyWith({
    List<SpecialtyModel>? specialtyModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return SpecialtyState(
      specialtyModels: specialtyModels ?? this.specialtyModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'SpecialityState(specialtyModels: $specialtyModels, errorMessage: $errorMessage, responseType: $responseType)';
}

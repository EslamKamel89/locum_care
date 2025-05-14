// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'university_cubit.dart';

class UniversityState {
  List<UniversityModel>? universityModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  UniversityState({
    this.universityModels,
    this.errorMessage,
    this.responseType,
  });

  UniversityState copyWith({
    List<UniversityModel>? universities,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return UniversityState(
      universityModels: universities ?? universityModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'UniversityState(universityModel: $universityModels, errorMessage: $errorMessage, responseType: $responseType)';
}

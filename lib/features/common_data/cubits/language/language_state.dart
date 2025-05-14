// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_cubit.dart';

class LanguageState {
  List<LanguageModel>? languageModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  LanguageState({
    this.languageModels,
    this.errorMessage,
    this.responseType,
  });

  LanguageState copyWith({
    List<LanguageModel>? languageModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return LanguageState(
      languageModels: languageModels ?? this.languageModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'LanguageState(specialtyModels: $languageModels, errorMessage: $errorMessage, responseType: $responseType)';
}

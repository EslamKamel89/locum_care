// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'skill_cubit.dart';

class SkillState {
  List<SkillModel>? skillModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  SkillState({
    this.skillModels,
    this.errorMessage,
    this.responseType,
  });

  SkillState copyWith({
    List<SkillModel>? skillModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return SkillState(
      skillModels: skillModels ?? this.skillModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'SkillState(specialtyModels: $skillModels, errorMessage: $errorMessage, responseType: $responseType)';
}

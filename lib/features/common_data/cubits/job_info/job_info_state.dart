// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'job_info_cubit.dart';

class JobInfoState {
  List<JobInfoModel>? jobInfoModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  JobInfoState({
    this.jobInfoModels,
    this.errorMessage,
    this.responseType,
  });

  JobInfoState copyWith({
    List<JobInfoModel>? jobInfoModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return JobInfoState(
      jobInfoModels: jobInfoModels ?? this.jobInfoModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'JobInfoState(jobInfoModels: $jobInfoModels, errorMessage: $errorMessage, responseType: $responseType)';
}

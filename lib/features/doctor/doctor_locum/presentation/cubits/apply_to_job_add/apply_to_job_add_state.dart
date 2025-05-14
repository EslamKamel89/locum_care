// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'apply_to_job_add_cubit.dart';

class ApplyToJobAddState {
  JobApplicationModel? jobApplicationModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  ApplyToJobAddState({
    this.jobApplicationModel,
    this.errorMessage,
    this.responseType,
  });

  ApplyToJobAddState copyWith({
    JobApplicationModel? jobApplicationModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return ApplyToJobAddState(
      jobApplicationModel: jobApplicationModel ?? this.jobApplicationModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'ApplyToJobAddState(jobApplicationModel: $jobApplicationModel, errorMessage: $errorMessage, responseType: $responseType)';
}

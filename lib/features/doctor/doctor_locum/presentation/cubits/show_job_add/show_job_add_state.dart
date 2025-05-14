// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_job_add_cubit.dart';

class ShowJobAddState {
  JobAddModel? jobAddModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  ShowJobAddState({
    this.jobAddModel,
    this.errorMessage,
    this.responseType,
  });

  ShowJobAddState copyWith({
    JobAddModel? jobAddModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return ShowJobAddState(
      jobAddModel: jobAddModel ?? this.jobAddModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'ShowJobAddState(jobAddModel: $jobAddModel, errorMessage: $errorMessage, responseType: $responseType)';
}

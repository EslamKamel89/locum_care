// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doctor_job_application_cubit.dart';

class DoctorJobApplicationState {
  ResponseModel<List<JobApplicationDetailsModel>>?
      jobApplicationDetailsResponse;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  int? limit;
  int? page;
  bool? hasNextPage;
  String? status;
  DoctorJobApplicationState({
    this.jobApplicationDetailsResponse,
    this.errorMessage,
    this.responseType,
    this.limit = 5,
    this.page = 0,
    this.hasNextPage = true,
    this.status,
  });

  DoctorJobApplicationState copyWith({
    ResponseModel<List<JobApplicationDetailsModel>>?
        jobApplicationDetailsResponse,
    String? errorMessage,
    ResponseEnum? responseType,
    int? limit,
    int? page,
    bool? hasNextPage,
    String? status,
  }) {
    return DoctorJobApplicationState(
      jobApplicationDetailsResponse:
          jobApplicationDetailsResponse ?? this.jobApplicationDetailsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'DoctorJobApplicationState(jobApplicationDetailsResponse: $jobApplicationDetailsResponse, errorMessage: $errorMessage, responseType: $responseType, limit: $limit, page: $page, hasNextPage: $hasNextPage, status: $status)';
  }
}

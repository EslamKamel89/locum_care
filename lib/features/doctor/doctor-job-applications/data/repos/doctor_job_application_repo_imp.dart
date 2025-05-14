import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/data/remote_datasource/doctor_job_application_remote_datasource.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/repos/doctor_job_application_repo.dart';

class DoctorJobApplicationRepoImp implements DoctorJobApplicationRepo {
  final DoctorJobApplicationRemoteDataSource remoteDataSource;

  DoctorJobApplicationRepoImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, ResponseModel<List<JobApplicationDetailsModel>>>> showAllJobApplication({
    required int limit,
    required int page,
    String? status,
  }) async {
    final t = prt('showAllJobApplication  - DoctorJobApplicationRepoImp');
    try {
      ResponseModel<List<JobApplicationDetailsModel>> response = await remoteDataSource
          .showAllJobApplication(limit: limit, page: page, status: status);
      return Right(pr(response, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}

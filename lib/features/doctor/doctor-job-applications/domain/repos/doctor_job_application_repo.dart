import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';

abstract class DoctorJobApplicationRepo {
  Future<Either<Failure, ResponseModel<List<JobApplicationDetailsModel>>>> showAllJobApplication({
    required int limit,
    required int page,
    String? status,
  });
}

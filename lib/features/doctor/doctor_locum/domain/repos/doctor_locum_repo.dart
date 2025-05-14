// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/common_data/data/models/job_application_model.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';

abstract class DoctorLocumRepo {
  Future<Either<Failure, JobAddModel>> showJobAdd({required int jobAddId});
  Future<Either<Failure, ResponseModel<List<JobAddModel>>>> showAllJobAdds({
    required ShowAllJobAddsParams params,
  });
  Future<Either<Failure, JobApplicationModel>> applyJobAdd({
    required int jobAddId,
    required String notes,
  });
}

class ShowAllJobAddsParams {
  int? limit;
  int? page;
  String? jobInfo;
  String? specialty;
  int? createdAt;
  int? salaryMax;
  String? langs;
  String? skills;
  String? jobType;
  String? state;
  String? location;

  ShowAllJobAddsParams({
    this.limit,
    this.page,
    this.jobInfo,
    this.specialty,
    this.createdAt,
    this.salaryMax,
    this.langs,
    this.skills,
    this.jobType,
    this.state,
    this.location,
  });

  @override
  String toString() {
    return 'ShowAllJobAddsParams(limit: $limit, page: $page, jobInfo: $jobInfo, specialty: $specialty, createdAt: $createdAt, salaryMax: $salaryMax, langs: $langs, skills: $skills, jobType: $jobType, state: $state, location: $location)';
  }

  Map<String, dynamic> toJson() {
    final result = {
      'limit': limit,
      'page': page,
      'job_info': jobInfo,
      'specialty': specialty,
      'created_at': createdAt,
      'salary_max': salaryMax,
      'langs': langs,
      'skills': skills,
      'job_type': jobType,
      'state': state,
      'location': location,
    };
    result.removeWhere((key, value) => value == null);
    return result;
  }

  ShowAllJobAddsParams copyWith({
    int? limit,
    int? page,
    String? jobInfo,
    String? specialty,
    int? createdAt,
    int? salaryMax,
    String? langs,
    String? skills,
    String? jobType,
    String? state,
    String? location,
  }) {
    return ShowAllJobAddsParams(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      jobInfo: jobInfo ?? this.jobInfo,
      specialty: specialty ?? this.specialty,
      createdAt: createdAt ?? this.createdAt,
      salaryMax: salaryMax ?? this.salaryMax,
      langs: langs ?? this.langs,
      skills: skills ?? this.skills,
      jobType: jobType ?? this.jobType,
      state: state ?? this.state,
      location: location ?? this.location,
    );
  }
}

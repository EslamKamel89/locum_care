import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/data_source/common_data_remote_source.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/common_data/data/models/university_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

class CommonDataRepoImp implements CommonDataRepo {
  final CommonDataRemoteSource commonDataRemoteSource;

  CommonDataRepoImp({required this.commonDataRemoteSource});
  @override
  Future<Either<Failure, DistrictsDataModel>> fetchDistrictsData(int stateId) async {
    final t = prt('fetchDistrictsData  - CommonDataRepoImp');
    try {
      DistrictsDataModel model = await commonDataRemoteSource.fetchDistrictsData(stateId);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<JobInfoModel>>> fetchJobInfos() async {
    final t = prt('fetchJobInfos  - CommonDataRepoImp');
    try {
      List<JobInfoModel> models = await commonDataRemoteSource.fetchJobInfos();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<SpecialtyModel>>> fetchSpecialties() async {
    final t = prt('fetchSpecialties  - CommonDataRepoImp');
    try {
      List<SpecialtyModel> models = await commonDataRemoteSource.fetchSpecialties();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<StateModel>>> fetchStates() async {
    final t = prt('fetchStates  - CommonDataRepoImp');
    try {
      List<StateModel> models = await commonDataRemoteSource.fetchStates();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<UniversityModel>>> fetchUniversities() async {
    final t = prt('fetchUniversities  - CommonDataRepoImp');
    try {
      List<UniversityModel> models = await commonDataRemoteSource.fetchUniversities();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, Either<DoctorUserModel, HospitalUserModel>>> fetchUserInfo() async {
    final t = prt('fetchUserInfo  - CommonDataRepoImp');
    try {
      Either<DoctorUserModel, HospitalUserModel> model =
          await commonDataRemoteSource.fetchUserInfo();
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<LanguageModel>>> fetchLanguages() async {
    final t = prt('fetchLanguages  - CommonDataRepoImp');
    try {
      List<LanguageModel> models = await commonDataRemoteSource.fetchLanguages();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, List<SkillModel>>> fetchSkills() async {
    final t = prt('fetchSkills  - CommonDataRepoImp');
    try {
      List<SkillModel> models = await commonDataRemoteSource.fetchSkills();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}

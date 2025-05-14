import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/common_data/data/models/university_model.dart';

abstract class CommonDataRepo {
  Future<Either<Failure, List<SpecialtyModel>>> fetchSpecialties();
  Future<Either<Failure, List<StateModel>>> fetchStates();
  Future<Either<Failure, List<UniversityModel>>> fetchUniversities();
  Future<Either<Failure, List<JobInfoModel>>> fetchJobInfos();
  Future<Either<Failure, DistrictsDataModel>> fetchDistrictsData(int stateId);
  Future<Either<Failure, List<LanguageModel>>> fetchLanguages();
  Future<Either<Failure, List<SkillModel>>> fetchSkills();
  Future<Either<Failure, Either<DoctorUserModel, HospitalUserModel>>> fetchUserInfo();
}

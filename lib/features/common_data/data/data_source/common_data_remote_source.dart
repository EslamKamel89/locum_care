// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/common_data/data/models/university_model.dart';

class CommonDataRemoteSource {
  final ApiConsumer api;
  CommonDataRemoteSource({required this.api});
  Future<List<SpecialtyModel>> fetchSpecialties() async {
    final t = prt('fetchSpecialties - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchSpecialties);
    List<SpecialtyModel> specialties =
        data['data'].map<SpecialtyModel>((e) => SpecialtyModel.fromJson(e)).toList();

    return pr(specialties, t);
  }

  Future<List<StateModel>> fetchStates() async {
    final t = prt('fetchStates - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchStates);
    List<StateModel> stateModels =
        data['data'].map<StateModel>((e) => StateModel.fromJson(e)).toList();

    return pr(stateModels, t);
  }

  Future<List<UniversityModel>> fetchUniversities() async {
    final t = prt('fetchUniversities - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchUniversities);
    List<UniversityModel> universityModels =
        data['data'].map<UniversityModel>((e) => UniversityModel.fromJson(e)).toList();

    return pr(universityModels, t);
  }

  Future<List<JobInfoModel>> fetchJobInfos() async {
    final t = prt('fetchJobInfos - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchJobInfos);
    List<JobInfoModel> jobInfoModels =
        data['data'].map<JobInfoModel>((e) => JobInfoModel.fromJson(e)).toList();

    return pr(jobInfoModels, t);
  }

  Future<DistrictsDataModel> fetchDistrictsData(int stateId) async {
    final t = prt('fetchDistrictsData - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchDistrictsData, queryParameter: {'state_id': stateId});
    DistrictsDataModel districtsDataModel = DistrictsDataModel.fromJson(data['data']);

    return pr(districtsDataModel, t);
  }

  Future<Either<DoctorUserModel, HospitalUserModel>> fetchUserInfo() async {
    final t = prt('fetchUserInfo - CommonDataRemoteSource');
    // String? token = await FirebaseMessaging.instance.getToken();
    String? token;

    final data = await api.get(EndPoint.userInfo, queryParameter: {'fcm_token': token});
    if (data['data']['type'] == 'doctor') {
      return Left(pr(DoctorUserModel.fromJson(data['data']['user']), t));
    }
    if (data['data']['type'] == 'hospital') {
      return Right(pr(HospitalUserModel.fromJson(data['data']['user']), t));
    }
    pr('Error: type in response is not doctor or hospital', t);
    throw ServerFailure('Unkwon error occured');
  }

  Future<List<LanguageModel>> fetchLanguages() async {
    final t = prt('fetchLanguages - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchLangs);
    List<LanguageModel> languageModels =
        data['data'].map<LanguageModel>((e) => LanguageModel.fromJson(e)).toList();

    return pr(languageModels, t);
  }

  Future<List<SkillModel>> fetchSkills() async {
    final t = prt('fetchSkills - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchSkills);
    List<SkillModel> skillModels =
        data['data'].map<SkillModel>((e) => SkillModel.fromJson(e)).toList();

    return pr(skillModels, t);
  }
}

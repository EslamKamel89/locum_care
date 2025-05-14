// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/hospital_info_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_model.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';

class HospitalProfileRemoteDatasource {
  final ApiConsumer api;
  HospitalProfileRemoteDatasource({required this.api});
  Future<HospitalModel> updateOrCreateHospital({
    required HospitalParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateHospital - HospitalProfileRemoteDatasource');

    Map<String, dynamic> requestData = await params.toJson();
    if (!create) {
      requestData.addAll({'id': id});
    }
    final data = await api.post(
      EndPoint.hospitalCreateOrUpdate,
      isFormData: true,
      data: requestData,
    );
    HospitalModel hospitalModel = HospitalModel.fromJson(data['data']);

    return pr(hospitalModel, t);
  }

  Future<HospitalInfoModel> updateOrCreateHospitalInfo({
    required HospitalInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateHospitalInfo - HospitalProfileRemoteDatasource');

    Map<String, dynamic> requestData = params.toJson();
    if (!create) {
      requestData.addAll({'id': id});
    }
    final data = await api.post(EndPoint.hospitalInfoCreateOrUpdate, data: requestData);
    HospitalInfoModel hospitalInfoModel = HospitalInfoModel.fromJson(data['data']);

    return pr(hospitalInfoModel, t);
  }
}

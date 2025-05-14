import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

class DoctorProfileRemoteDataSource {
  final ApiConsumer api;

  DoctorProfileRemoteDataSource({required this.api});
  Future<DoctorInfoModel> updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctorInfo - DoctorProfileRemoteDataSource');
    // Map<String, dynamic> requestData = create ? params.toJson() : params.toJson()
    //   ..addAll({'id': id});
    Map<String, dynamic> requestData = await params.toJson();
    if (!create) {
      requestData.addAll({'id': id});
    }
    final data = await api.post(
      EndPoint.doctorInfoCreateOrUpdate,
      isFormData: true,
      data: requestData,
    );
    DoctorInfoModel doctorInfoModel = DoctorInfoModel.fromJson(data['data']);

    return pr(doctorInfoModel, t);
  }

  Future<DoctorModel> updateOrCreateDoctor({
    required DoctorParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctor - DoctorProfileRemoteDataSource');
    // Map<String, dynamic> requestData = create ? params.toJson() : params.toJson()
    //   ..addAll({'id': id});
    Map<String, dynamic> requestData = await params.toJson();
    if (!create) {
      requestData.addAll({'id': id});
    }
    final data = await api.post(EndPoint.doctorCreateOrUpdate, isFormData: true, data: requestData);
    DoctorModel doctorModel = DoctorModel.fromJson(data['data']);

    return pr(doctorModel, t);
  }

  Future<UserModel> updateUserDoctor({required UserDoctorParams params}) async {
    final t = prt('updateUserDoctor - DoctorProfileRemoteDataSource');

    final data = await api.post(EndPoint.updateUser, data: params.toJson());
    UserModel userModel = UserModel.fromJson(data['data']);

    return pr(userModel, t);
  }

  Future<DoctorDocumentModel> createDoctorDocument({
    required CreateDoctorDocumentParams params,
  }) async {
    final t = prt('createDoctorDocument - DoctorProfileRemoteDataSource');

    Map<String, dynamic> requestData = await params.toJson();

    final data = await api.post(EndPoint.createDoctorDocument, isFormData: true, data: requestData);
    DoctorDocumentModel doctorDocumentModel = DoctorDocumentModel.fromJson(data['data']);

    return pr(doctorDocumentModel, t);
  }

  Future<bool> deleteDoctorDocument({required int id}) async {
    final t = prt('deleteDoctorDocument - DoctorProfileRemoteDataSource');

    final data = await api.delete("${EndPoint.deleteDoctorDocument}/$id");
    bool success = data['message'] == 'Resource Deleted Successfully';

    return pr(success, t);
  }
}

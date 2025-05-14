import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/job_application_model.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

class DoctorLocumRemoteDataSource {
  final ApiConsumer api;

  DoctorLocumRemoteDataSource({required this.api});

  Future<JobAddModel> showJobAdd({required int jobAddId}) async {
    final t = prt('showJobAdd - DoctorLocumRemoteDataSource');

    final data = await api.get(EndPoint.showJobAdd(jobAddId));
    JobAddModel jobAddModel = JobAddModel.fromJson(data['data']);

    return pr(jobAddModel, t);
  }

  Future<ResponseModel<List<JobAddModel>>> showAllJobAdds({
    required ShowAllJobAddsParams params,
  }) async {
    final t = prt('showAllJobAdds - DoctorLocumRemoteDataSource');
    final data = await api.get(EndPoint.showAllJobAdds, queryParameter: params.toJson());
    ResponseModel<List<JobAddModel>> response = ResponseModel.fromJson(data);
    List<JobAddModel> jobAddModels =
        data['data'].map<JobAddModel>((e) => JobAddModel.fromJson(e)).toList();
    response.data = jobAddModels;

    return pr(response, t);
  }

  Future<JobApplicationModel> applyJobAdd({required int jobAddId, required String notes}) async {
    final t = prt('applyJobAdd - DoctorLocumRemoteDataSource');
    final data = await api.post(
      EndPoint.applyToJobAdd,
      data: {"job_add_id": jobAddId, "additional_notes": notes},
    );
    JobApplicationModel model = JobApplicationModel.fromJson(data['data']);

    return pr(model, t);
  }
}

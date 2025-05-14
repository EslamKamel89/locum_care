import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';

class DoctorJobApplicationRemoteDataSource {
  final ApiConsumer api;

  DoctorJobApplicationRemoteDataSource({required this.api});

  Future<ResponseModel<List<JobApplicationDetailsModel>>> showAllJobApplication({
    required int limit,
    required int page,
    String? status,
  }) async {
    final t = prt('showAllJobApplication - DoctorJobApplicationRemoteDataSource');
    Map<String, dynamic> queryParamater = {"limit": limit, "page": page};
    if (status != null) {
      queryParamater.addAll({'status': status});
    }
    final data = await api.get(EndPoint.showDoctorJobApplication, queryParameter: queryParamater);
    ResponseModel<List<JobApplicationDetailsModel>> response = ResponseModel.fromJson(data);
    List<JobApplicationDetailsModel> jobApplicationModels =
        data['data']
            .map<JobApplicationDetailsModel>((e) => JobApplicationDetailsModel.fromJson(e))
            .toList();
    response.data = jobApplicationModels;

    return pr(response, t);
  }
}

import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';

class ViewHospitalProfileRemoteDatasource {
  final ApiConsumer api;

  ViewHospitalProfileRemoteDatasource({required this.api});
  Future<HospitalUserModel> fetchHospitalProfileInfo({required int id}) async {
    final t = prt('fetchHospitalProfileInfo - ViewHospitalProfileRemoteDatasource');

    final data = await api.get(EndPoint.showHospialProfile(id));

    return pr(HospitalUserModel.fromJson(data['data']), t);
  }
}

import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/doctor/support/domain/models/not_seen_count_model.dart';
import 'package:locum_care/features/doctor/support/domain/models/support_model.dart';

class SupportRemoteDatasource {
  final ApiConsumer api;
  SupportRemoteDatasource({required this.api});
  Future<List<SupportModel>> fetchAllSupport() async {
    final t = prt('fetchAllSupport - SupportRemoteDatasource');
    final data = await api.get(EndPoint.getAllSupport);
    List<SupportModel> models =
        data['data'].map<SupportModel>((e) => SupportModel.fromJson(e)).toList();

    return pr(models, t);
  }

  Future<SupportModel> sendSupportMessage(String content) async {
    final t = prt('sendSupportMessage - SupportRemoteDatasource');
    final data = await api.post(EndPoint.sendSupportMessage, data: {'content': content});
    SupportModel model = SupportModel.fromJson(data['data']);

    return pr(model, t);
  }

  Future<NotSeenCountModel> getUnseenCount() async {
    final t = prt('getUnseenCount - SupportRemoteDatasource');
    final data = await api.get(EndPoint.unseenCount);
    NotSeenCountModel model = NotSeenCountModel.fromJson(data['data']);

    return pr(model, t);
  }
}

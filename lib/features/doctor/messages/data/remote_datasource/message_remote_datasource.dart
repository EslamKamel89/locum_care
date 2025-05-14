import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/doctor/messages/domain/models/message_card_model.dart';

class MessageRemoteDatasource {
  final ApiConsumer api;
  MessageRemoteDatasource({required this.api});
  Future<List<MessageCardModel>> fetchAllChat() async {
    final t = prt('fetchAllChat - MessageRemoteDatasource');
    final data = await api.get(EndPoint.getAllChat);
    List<MessageCardModel> messageCard =
        data['data'].map<MessageCardModel>((e) => MessageCardModel.fromJson(e)).toList();

    return pr(messageCard, t);
  }
}

import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/doctor/messages/domain/models/message_card_model.dart';

abstract class MessageRepo {
  Future<Either<Failure, List<MessageCardModel>>> fetchAllChat();
}

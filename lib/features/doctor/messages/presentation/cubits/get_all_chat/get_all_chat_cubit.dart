// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/doctor/messages/domain/models/message_card_model.dart';
import 'package:locum_care/features/doctor/messages/domain/repos/message_repo.dart';

part 'get_all_chat_state.dart';

class GetAllChatCubit extends Cubit<GetAllChatState> {
  MessageRepo repo;
  GetAllChatCubit({required this.repo}) : super(GetAllChatState(messageCards: []));
  Future fetchAllChat() async {
    final t = prt('fetchAllChat - GetAllChatCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await repo.fetchAllChat();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<MessageCardModel> models) async {
        pr(models, t);
        state.messageCards = [];
        emit(
          state.copyWith(
            messageCards: models,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

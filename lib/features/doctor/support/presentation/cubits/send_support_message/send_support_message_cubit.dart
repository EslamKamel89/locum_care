// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/doctor/support/domain/models/support_model.dart';
import 'package:locum_care/features/doctor/support/domain/repos/support_repo.dart';

part 'send_support_message_state.dart';

class SendSupportMessageCubit extends Cubit<SendSupportMessageState> {
  final SupportRepo repo;
  SendSupportMessageCubit(this.repo) : super(SendSupportMessageState());
  Future sendSupportMessage(String content) async {
    final t = prt('sendSupportMessage - SendSupportMessageCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await repo.sendSupportMessage(content);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (SupportModel model) async {
        pr(model, t);
        emit(
          state.copyWith(
            supportModel: model,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

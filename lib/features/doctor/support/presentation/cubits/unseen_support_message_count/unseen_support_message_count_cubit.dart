import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/doctor/support/domain/models/not_seen_count_model.dart';
import 'package:locum_care/features/doctor/support/domain/repos/support_repo.dart';

part 'unseen_support_message_count_state.dart';

class UnseenSupportMessageCountCubit extends Cubit<UnseenSupportMessageCountState> {
  final SupportRepo repo;
  UnseenSupportMessageCountCubit(this.repo) : super(UnseenSupportMessageCountState());
  Future getUnseenCount() async {
    final t = prt('getUnseenCount - UnseenSupportMessageCountCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await repo.getUnseenCount();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (NotSeenCountModel model) async {
        pr(model, t);
        emit(
          state.copyWith(
            notSeenCountModel: model,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

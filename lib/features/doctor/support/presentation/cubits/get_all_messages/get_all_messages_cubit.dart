// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/doctor/support/domain/models/support_model.dart';
import 'package:locum_care/features/doctor/support/domain/repos/support_repo.dart';

part 'get_all_messages_state.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  final SupportRepo repo;
  GetAllMessagesCubit({required this.repo}) : super(GetAllMessagesState(supportModels: []));
  Future fetchAllSupport() async {
    final t = prt('fetchAllSupport - GetAllMessagesCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await repo.fetchAllSupport();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<SupportModel> models) async {
        pr(models, t);
        state.supportModels = [];
        emit(
          state.copyWith(
            supportModels: models,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void addMessage(String content) async {
    emit(
      state.copyWith(
        supportModels: [
          ...state.supportModels ?? [],
          SupportModel(content: content, sender: 'user', createdAt: 'Pending...'),
        ],
        responseType: ResponseEnum.success,
        errorMessage: null,
      ),
    );
    fetchAllSupport();
  }
}

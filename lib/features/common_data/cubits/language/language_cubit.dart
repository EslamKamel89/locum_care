// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final CommonDataRepo commonDataRepo;
  LanguageCubit(this.commonDataRepo) : super(LanguageState());

  Future fetchLanugages() async {
    final t = prt('fetchLanugages - LanguageCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchLanguages();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<LanguageModel> langs) async {
        pr(langs, t);
        emit(
          state.copyWith(
            languageModels: langs,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

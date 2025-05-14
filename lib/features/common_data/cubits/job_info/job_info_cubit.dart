// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'job_info_state.dart';

class JobInfoCubit extends Cubit<JobInfoState> {
  final CommonDataRepo commonDataRepo;
  JobInfoCubit(this.commonDataRepo) : super(JobInfoState());

  Future fetchJobInfos() async {
    final t = prt('fetchJobInfos - JobInfoCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchJobInfos();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<JobInfoModel> jobInfos) async {
        pr(jobInfos, t);
        emit(
          state.copyWith(
            jobInfoModels: jobInfos,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

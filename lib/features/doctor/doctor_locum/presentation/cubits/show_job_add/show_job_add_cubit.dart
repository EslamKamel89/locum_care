import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

part 'show_job_add_state.dart';

class ShowJobAddCubit extends Cubit<ShowJobAddState> {
  final DoctorLocumRepo doctorLocumRepo;
  ShowJobAddCubit(this.doctorLocumRepo) : super(ShowJobAddState());
  Future showJobAdd({required int jobAddId}) async {
    final t = prt('showJobAdd - ShowJobAddCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await doctorLocumRepo.showJobAdd(jobAddId: jobAddId);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (JobAddModel jobAddModel) async {
        pr(jobAddModel, t);
        emit(
          state.copyWith(
            jobAddModel: jobAddModel,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

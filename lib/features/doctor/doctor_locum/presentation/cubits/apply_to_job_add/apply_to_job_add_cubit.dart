import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/job_application_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

part 'apply_to_job_add_state.dart';

class ApplyToJobAddCubit extends Cubit<ApplyToJobAddState> {
  final DoctorLocumRepo doctorLocumRepo;
  ApplyToJobAddCubit(this.doctorLocumRepo) : super(ApplyToJobAddState());

  Future applyJobAdd({required int jobAddId, required String notes}) async {
    final t = prt('applyJobAdd - ApplyToJobAddCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await doctorLocumRepo.applyJobAdd(jobAddId: jobAddId, notes: notes);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (JobApplicationModel jobApplicationModel) async {
        pr(jobApplicationModel, t);
        emit(
          state.copyWith(
            jobApplicationModel: jobApplicationModel,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

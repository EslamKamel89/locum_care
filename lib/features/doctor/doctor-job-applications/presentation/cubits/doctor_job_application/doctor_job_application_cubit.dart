// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/repos/doctor_job_application_repo.dart';

part 'doctor_job_application_state.dart';

class DoctorJobApplicationCubit extends Cubit<DoctorJobApplicationState> {
  final DoctorJobApplicationRepo doctorJobApplicationRepo;
  DoctorJobApplicationCubit(this.doctorJobApplicationRepo) : super(DoctorJobApplicationState());

  void resetState() {
    emit(DoctorJobApplicationState());
  }

  Future showAllJobApplication([String? status]) async {
    final t = prt('showAllJobApplication - DoctorJobApplicationCubit');
    if (state.responseType == ResponseEnum.loading) {
      pr('Still loading data exiting showAllJobApplication ', t);
      return;
    }
    if (state.hasNextPage != true) {
      pr('No more pages exiting showAllJobApplication ', t);
      return;
    }
    if (status != null) {
      emit(
        state.copyWith(
          responseType: ResponseEnum.loading,
          errorMessage: null,
          page: state.page! + 1,
          status: status,
        ),
      );
    } else {
      emit(
        state.copyWith(
          responseType: ResponseEnum.loading,
          errorMessage: null,
          page: state.page! + 1,
        ),
      );
    }

    final result = await doctorJobApplicationRepo.showAllJobApplication(
      limit: pr(state.limit!, '$t limit'),
      page: pr(state.page!, '$t page'),
      status: state.status,
    );
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (ResponseModel<List<JobApplicationDetailsModel>> jobApplications) async {
        pr(jobApplications, t);
        pr(jobApplications.pagination, t);
        jobApplications.data = [
          ...state.jobApplicationDetailsResponse?.data ?? [],
          ...jobApplications.data ?? [],
        ];
        emit(
          state.copyWith(
            jobApplicationDetailsResponse: jobApplications,
            responseType: ResponseEnum.success,
            errorMessage: null,
            hasNextPage: jobApplications.pagination?.hasMorePages ?? false,
          ),
        );
      },
    );
  }
}

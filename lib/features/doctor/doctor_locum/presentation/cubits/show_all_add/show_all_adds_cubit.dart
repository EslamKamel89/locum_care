// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

part 'show_all_adds_state.dart';

class ShowAllAddsCubit extends Cubit<ShowAllAddsState> {
  final DoctorLocumRepo doctorLocumRepo;
  ShowAllAddsCubit(this.doctorLocumRepo) : super(ShowAllAddsState());
  void resetState() {
    emit(ShowAllAddsState());
  }

  Future showAllJobAdds([ShowAllJobAddsParams? params]) async {
    final t = prt('showAllJobAdds - ShowAllAddsCubit');
    if (state.responseType == ResponseEnum.loading) {
      pr('Still loading data exiting showAllJobAdds ', t);
      return;
    }
    if (state.hasNextPage != true) {
      pr('No more pages exiting showAllJobAdds ', t);
      return;
    }
    if (params != null) {
      params.limit = state.limit!;
      params.page = state.page! + 1;
      emit(
        state.copyWith(
          responseType: ResponseEnum.loading,
          errorMessage: null,
          page: state.page! + 1,
          params: params,
        ),
      );
    } else {
      emit(
        state.copyWith(
          responseType: ResponseEnum.loading,
          errorMessage: null,
          page: state.page! + 1,
          params: params?.copyWith(limit: state.limit, page: state.page),
        ),
      );
    }
    // params = params ?? ShowAllJobAddsParams();
    // params.limit = state.limit!;
    // params.page = state.page;
    final result = await doctorLocumRepo.showAllJobAdds(
      params: pr(
        state.params ?? ShowAllJobAddsParams(limit: state.limit, page: state.page),
        '$t params used in the request',
      ),
    );
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (ResponseModel<List<JobAddModel>> jobAdds) async {
        pr(jobAdds, t);
        pr(jobAdds.pagination, t);
        jobAdds.data = [...state.jobAddsResponse?.data ?? [], ...jobAdds.data ?? []];
        emit(
          state.copyWith(
            jobAddsResponse: jobAdds,
            responseType: ResponseEnum.success,
            errorMessage: null,
            hasNextPage: jobAdds.pagination?.hasMorePages ?? false,
          ),
        );
      },
    );
  }
}

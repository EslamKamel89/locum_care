import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'districts_data_state.dart';

class DistrictsDataCubit extends Cubit<DistrictsDataState> {
  final CommonDataRepo commonDataRepo;
  DistrictsDataCubit(this.commonDataRepo) : super(DistrictsDataState());

  Future fetchDistrictsData(int stateId) async {
    final t = prt('fetchDistrictsData - DistrictsDataCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchDistrictsData(stateId);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (DistrictsDataModel districtData) async {
        pr(districtData, t);
        emit(
          state.copyWith(
            districtsDataModel: districtData,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

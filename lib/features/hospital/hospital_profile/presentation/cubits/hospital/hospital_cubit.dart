// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_model.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalProfileRepo hospitalProfileRepo;
  HospitalCubit(this.hospitalProfileRepo) : super(HospitalState());
  Future updateOrCreateHospital({
    required HospitalParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateHospital - HospitalCubit');
    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        hospitalParams: params,
      ),
    );
    final result = await hospitalProfileRepo.updateOrCreateHospital(
      params: params,
      create: create,
      id: id,
    );
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (HospitalModel hospitalModel) async {
        pr(hospitalModel, t);
        await _updateUserInfoState();
        emit(
          state.copyWith(
            hospitalModel: hospitalModel,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future _updateUserInfoState() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    await context.read<UserInfoCubit>().fetchUserInfo();
  }
}

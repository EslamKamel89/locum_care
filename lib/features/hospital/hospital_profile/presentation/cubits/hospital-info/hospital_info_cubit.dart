// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_info_model.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';

part 'hospital_info_state.dart';

class HospitalInfoCubit extends Cubit<HospitalInfoState> {
  final HospitalProfileRepo hospitalProfileRepo;
  HospitalInfoCubit(this.hospitalProfileRepo) : super(HospitalInfoState());

  Future updateOrCreateHospitalInfo({
    required HospitalInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateHospitalInfo - HospitalInfoCubit');
    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        hospitalInfoParams: params,
      ),
    );
    final result = await hospitalProfileRepo.updateOrCreateHospitalInfo(
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
      (HospitalInfoModel hospitalInfoModel) async {
        pr(hospitalInfoModel, t);
        await _updateUserInfoState();
        emit(
          state.copyWith(
            hospitalInfoModel: hospitalInfoModel,
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

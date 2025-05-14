import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

part 'doctor_info_state.dart';

class DoctorInfoCubit extends Cubit<DoctorInfoState> {
  final DoctorProfileRepo doctorProfileRepo;
  DoctorInfoCubit({required this.doctorProfileRepo}) : super(DoctorInfoState());
  Future updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctorInfo - DoctorInfoCubit');
    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        doctorInfoParams: params,
      ),
    );
    final result = await doctorProfileRepo.updateOrCreateDoctorInfo(
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
      (DoctorInfoModel doctorInfoModel) async {
        pr(doctorInfoModel, t);
        await _updateUserInfoState();
        emit(
          state.copyWith(
            doctorInfoModel: doctorInfoModel,
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

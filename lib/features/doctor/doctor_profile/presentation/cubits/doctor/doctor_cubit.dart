// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorProfileRepo doctorProfileRepo;
  DoctorCubit(this.doctorProfileRepo) : super(DoctorState());
  Future updateOrCreateDoctor({required DoctorParams params, required bool create, int? id}) async {
    final t = prt('updateOrCreateDoctor - DoctorCubit');
    emit(
      state.copyWith(responseType: ResponseEnum.loading, errorMessage: null, doctorParams: params),
    );
    final result = await doctorProfileRepo.updateOrCreateDoctor(
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
      (DoctorModel doctorModel) async {
        pr(doctorModel, t);
        await _updateUserInfoState();
        emit(
          state.copyWith(
            doctorModel: doctorModel,
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

part 'user_update_state.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  final DoctorProfileRepo doctorProfileRepo;
  UserUpdateCubit(this.doctorProfileRepo) : super(UserUpdateState());
  Future updateUserDoctor({required UserDoctorParams params}) async {
    final t = prt('updateUserDoctor - UserDoctorCubit');
    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        doctorInfoParams: params,
      ),
    );
    final result = await doctorProfileRepo.updateUserDoctor(params: params);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (UserModel userModel) async {
        pr(userModel, t);
        await _updateUserInfoState();
        emit(
          state.copyWith(
            userModel: userModel,
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

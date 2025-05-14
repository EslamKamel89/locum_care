// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/hospital_profile/domain/repo/view_hospital_profile_repo.dart';

part 'view_hospital_profile_state.dart';

class ViewHospitalProfileCubit extends Cubit<ViewHospitalProfileState> {
  final ViewHospitalProfileRepo repo;
  ViewHospitalProfileCubit(this.repo) : super(ViewHospitalProfileState());
  Future fetchHospitalProfileInfo({required int id}) async {
    final t = prt('fetchHospitalProfileInfo - ViewHospitalProfileCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await repo.fetchHospitalProfileInfo(id: id);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (HospitalUserModel model) {
        pr(model, t);
        emit(
          state.copyWith(
            hospitalUserModel: model,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

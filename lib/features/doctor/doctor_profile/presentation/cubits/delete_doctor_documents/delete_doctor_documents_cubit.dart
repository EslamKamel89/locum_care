import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

part 'delete_doctor_documents_state.dart';

class DeleteDoctorDocumentsCubit extends Cubit<DeleteDoctorDocumentsState> {
  final DoctorProfileRepo doctorProfileRepo;
  DeleteDoctorDocumentsCubit(this.doctorProfileRepo) : super(DeleteDoctorDocumentsState());
  Future deleteDoctorDocument({required int id}) async {
    final t = prt('deleteDoctorDocument - DeleteDoctorDocumentsCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await doctorProfileRepo.deleteDoctorDocument(id: id);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (bool result) async {
        pr(result, t);
        await _updateUserInfoState();
        if (isClosed) return;
        emit(
          state.copyWith(
            deleteResult: result,
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

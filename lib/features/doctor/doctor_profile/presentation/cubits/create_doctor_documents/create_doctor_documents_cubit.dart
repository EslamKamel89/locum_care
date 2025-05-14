import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

part 'create_doctor_documents_state.dart';

class CreateDoctorDocumentsCubit extends Cubit<CreateDoctorDocumentsState> {
  final DoctorProfileRepo doctorProfileRepo;
  CreateDoctorDocumentsCubit(this.doctorProfileRepo) : super(CreateDoctorDocumentsState());
  Future createDoctorDocument({required CreateDoctorDocumentParams params}) async {
    final t = prt('createDoctorDocument - CreateDoctorDocumentsCubit');
    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        doctorDocumentParams: params,
      ),
    );
    final result = await doctorProfileRepo.createDoctorDocument(params: params);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (DoctorDocumentModel doctorDocumentModel) async {
        pr(doctorDocumentModel, t);
        await _updateUserInfoState();
        if (isClosed) return;
        emit(
          state.copyWith(
            doctorDocumentModel: doctorDocumentModel,
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

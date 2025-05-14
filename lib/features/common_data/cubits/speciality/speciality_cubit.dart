import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'speciality_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  final CommonDataRepo commonDataRepo;
  SpecialtyCubit(this.commonDataRepo) : super(SpecialtyState());
  Future fetchSpecialties() async {
    final t = prt('fetchSpecialties - SpecialityCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchSpecialties();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<SpecialtyModel> sepecialties) async {
        pr(sepecialties, t);
        emit(
          state.copyWith(
            specialtyModels: sepecialties,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

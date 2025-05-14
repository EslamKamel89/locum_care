import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/university_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'university_state.dart';

class UniversityCubit extends Cubit<UniversityState> {
  final CommonDataRepo commonDataRepo;
  UniversityCubit(this.commonDataRepo) : super(UniversityState());
  Future fetchUniversities() async {
    final t = prt('fetchUniversities - UniversityCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchUniversities();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<UniversityModel> universities) async {
        pr(universities, t);
        emit(
          state.copyWith(
            universities: universities,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

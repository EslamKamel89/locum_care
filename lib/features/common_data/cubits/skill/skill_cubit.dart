// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'skill_state.dart';

class SkillCubit extends Cubit<SkillState> {
  final CommonDataRepo commonDataRepo;
  SkillCubit(this.commonDataRepo) : super(SkillState());

  Future fetchSkills() async {
    final t = prt('fetchSkills - SkillCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchSkills();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<SkillModel> skills) async {
        pr(skills, t);
        emit(
          state.copyWith(
            skillModels: skills,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

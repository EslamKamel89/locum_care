import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'state_state.dart';

class StateCubit extends Cubit<StateState> {
  final CommonDataRepo commonDataRepo;
  StateCubit(this.commonDataRepo) : super(StateState());
  Future fetchStates() async {
    final t = prt('fetchStates - StateCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await commonDataRepo.fetchStates();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<StateModel> states) async {
        pr(states, t);
        emit(
          state.copyWith(
            stateModels: states,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}

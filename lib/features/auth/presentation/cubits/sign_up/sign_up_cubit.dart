// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/enums/user_type_enum.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_care/features/auth/helpers/auth_helpers.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/district_model.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final CommonDataRepo commonDataRepo;
  final AuthRepo authRepo;
  SignUpCubit({required this.commonDataRepo, required this.authRepo}) : super(SignUpState());
  Future fetchStates() async {
    final t = prt('fetchStates - SignUpCubit');
    // emit(state.copyWith(responseType: ResponseType.loading, errorMessage: null));
    final result = await commonDataRepo.fetchStates();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (List<StateModel> states) {
        pr(states, t);
        emit(
          state.copyWith(states: states, responseType: ResponseEnum.success, errorMessage: null),
        );
      },
    );
  }

  Future fetchDistrict(String selectedStateName) async {
    final t = prt('fetchDistrict - SignUpCubit');
    StateModel? selectedStateModel =
        state.states?.where((stateModel) => stateModel.name == selectedStateName).first;
    emit(state.copyWith(selectedState: selectedStateModel, errorMessage: null));
    if (selectedStateModel == null) {
      return;
    }
    final result = await commonDataRepo.fetchDistrictsData(selectedStateModel.id!);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (DistrictsDataModel districtsData) {
        pr(districtsData, t);
        emit(
          state.copyWith(
            districtsDataModel: districtsData,
            responseType: ResponseEnum.success,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void selectDistrict(String slectedDistricName) {
    DistrictModel? selectedDistrictModel =
        state.districtsDataModel?.districts
            ?.where((districtModel) => districtModel?.name == slectedDistricName)
            .first;
    emit(state.copyWith(selectdDistrict: selectedDistrictModel, errorMessage: null));
  }

  void selectUserType(String userTypeStr) {
    const t = 'selectUserType - SignUpCubit';
    UserTypeEnum? selectedUserType =
        UserTypeEnum.values.where((userType) => userType.toFullString() == userTypeStr).first;
    emit(state.copyWith(selectedUserType: pr(selectedUserType, t), errorMessage: null));
  }

  Future signUp(SignUpParams params) async {
    final t = prt('signUp - SignUpCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await authRepo.signup(params);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (UserModel user) async {
        pr(user, t);
        await AuthHelpers.cacheUser(user);
        await _updateUserInfoState();
        emit(
          state.copyWith(userEntity: user, responseType: ResponseEnum.success, errorMessage: null),
        );
        _navigateToHomeScreen();
      },
    );
  }

  Future _navigateToHomeScreen() async {
    final t = prt('navigateToHomeScreen - SignInCubit');
    Future.delayed(const Duration(seconds: 1)).then((_) {
      final context = navigatorKey.currentContext;
      final isDoctor = AuthHelpers.isDoctor();
      if (context == null || isDoctor == null) {
        pr('Error: context or isDoctor is null', t);
        return;
      }
      if (isDoctor) {
        pr('Navigate to doctors home page', t);
        Navigator.of(
          navigatorKey.currentContext!,
        ).pushNamedAndRemoveUntil(AppRoutesNames.doctorHomeScreen, (_) => false);
      } else {
        pr('Navigate to hospitals home page', t);
        Navigator.of(
          navigatorKey.currentContext!,
        ).pushNamedAndRemoveUntil(AppRoutesNames.hospitalHomeScreen, (_) => false);
      }
    });
  }

  Future _updateUserInfoState() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    await context.read<UserInfoCubit>().fetchUserInfo();
  }
}

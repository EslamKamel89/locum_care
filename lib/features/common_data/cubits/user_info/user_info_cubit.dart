// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/auth/helpers/auth_helpers.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final CommonDataRepo commonDataRepo;
  final SharedPreferences sharedPreferences;
  UserInfoCubit({required this.commonDataRepo, required this.sharedPreferences})
    : super(UserInfoState());

  Future fetchUserInfo([bool navigate = false]) async {
    final t = prt('fetchUserInfo - UserInfoCubit');
    emit(UserInfoState(responseType: ResponseEnum.loading));
    // if (!AuthHelpers.isSignedIn()) {
    //   _navigateToOnBoardingScreen();
    //   return;
    // }
    final result = await commonDataRepo.fetchUserInfo();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        // showSnackbar('Server Error', failure.message, true);
        _navigateToOnBoardingScreen();
        emit(UserInfoState(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (Either<DoctorUserModel, HospitalUserModel> doctorOrHospital) {
        pr(doctorOrHospital, t);
        doctorOrHospital.fold(
          (DoctorUserModel doctor) {
            AuthHelpers.cacheUser(doctor);
            emit(
              UserInfoState(
                doctorUserModel: doctor,
                userType: UserType.doctor,
                responseType: ResponseEnum.success,
              ),
            );
          },
          (HospitalUserModel hospital) {
            showSnackbar(
              'Error',
              'This is account is registered as a health care provider. You can use the web site',
              true,
            );
            return;
            AuthHelpers.cacheUser(hospital);
            emit(
              UserInfoState(
                hospitalUserModel: hospital,
                userType: UserType.hospital,
                responseType: ResponseEnum.success,
              ),
            );
          },
        );
        if (navigate) _navigateToHomeScreen();
      },
    );
  }

  Future _navigateToOnBoardingScreen() async {
    final t = prt('navigateToOnBoardingScreen - UserInfoCubit');
    pr('navigating to on boarding screen because the cached token is null', t);
    Navigator.of(
      navigatorKey.currentContext!,
    ).pushNamedAndRemoveUntil(AppRoutesNames.onboardingScreen, (_) => false);
  }

  Future _navigateToHomeScreen() async {
    final t = prt('navigateToHomeScreen - UserInfoCubit');

    final context = navigatorKey.currentContext;
    if (context == null) {
      pr('Error: context is null', t);
      return;
    }
    if (state.userType == UserType.doctor) {
      pr('Navigate to doctors home page', t);
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(AppRoutesNames.doctorHomeScreen, (_) => false);
      return;
    }
    if (state.userType == UserType.hospital) {
      pr('This user is signed as a health care professional cant use the mobile app', t);
      return;
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(AppRoutesNames.hospitalHomeScreen, (_) => false);
    }
    if (state.userType == null) {
      pr('Navigate to onboarding screen', t);
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(AppRoutesNames.onboardingScreen, (_) => false);
      return;
    }
  }

  Future handleSignOut() async {
    sharedPreferences.clear();
    emit(UserInfoState());
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.signinScreen, (_) => false);
  }
}

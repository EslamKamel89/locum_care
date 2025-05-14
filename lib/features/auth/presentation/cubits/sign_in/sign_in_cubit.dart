// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_care/features/auth/helpers/auth_helpers.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;
  SignInCubit({required this.authRepo}) : super(SignInState());
  Future signIn({required Map<String, String> signInData}) async {
    final t = prt('signIn - SignInCubit');
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null));
    final result = await authRepo.signIn(
      email: signInData['email']!,
      password: signInData['password']!,
    );
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
    final context = navigatorKey.currentContext;
    final isDoctor = AuthHelpers.isDoctor();
    if (context == null || isDoctor == null) {
      pr('Error: context or isDoctor is null', t);
      return;
    }
    if (isDoctor) {
      pr('Navigate to doctors home page', t);
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.doctorHomeScreen, (_) => false);
    } else {
      pr('This user is signed as health care provider and cant use the mobile app', t);
      return;
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutesNames.hospitalHomeScreen, (_) => false);
    }
  }

  Future _updateUserInfoState() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    await context.read<UserInfoCubit>().fetchUserInfo();
  }
}

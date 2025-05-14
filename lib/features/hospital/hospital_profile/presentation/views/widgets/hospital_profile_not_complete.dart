import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/add_info_widget.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/update_profile_widget.dart';

class HopitalProfileNotCompleteWidgets extends StatelessWidget {
  const HopitalProfileNotCompleteWidgets({super.key, required this.user});
  final HospitalUserModel? user;
  @override
  Widget build(BuildContext context) {
    context.watch<UserInfoCubit>();
    return Column(
      children: [
        SizedBox(height: 15.h),
        ProfileIncompleteWidget(
          title: 'Your Facility Main Information Incomplete',
          isVisible: user?.hospital == null,
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutesNames.hospitalForm, arguments: {'create': true});
          },
        ),
        Visibility(
          visible: user?.hospital != null,
          child: Column(
            children: [
              ProfileIncompleteWidget(
                title: 'Your Information Incomplete',
                message:
                    "Tell us more about your facility so we can connect you with the best locum talents.",
                isVisible: user?.hospital?.hospitalInfo == null,
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutesNames.hospitalInfoForm, arguments: {'create': true});
                },
              ),
              // AddDoctorInfoWidget(
              //   title: 'No Languages Added',
              //   message:
              //       "Let us know which languages you speak so we can match you with the perfect job!",
              //   buttonContent: "Add Language",
              //   isVisible: user?.doctor?.langs?.isEmpty ?? true,
              // ),
              // AddDoctorInfoWidget(
              //   isVisible: user?.doctor?.skills?.isEmpty ?? true,
              // ),
              AddDoctorInfoWidget(
                title: 'No Documents added',
                message:
                    "Upload your related documents to help healthcare professionals find what they need.",
                buttonContent: "Add Document",
                isVisible: user?.hospital?.hospitalDocuments?.isEmpty ?? true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

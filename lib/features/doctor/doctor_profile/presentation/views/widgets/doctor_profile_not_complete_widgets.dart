import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/update_or_create_document.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/create_doctor_documents/create_doctor_documents_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/add_info_widget.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/update_profile_widget.dart';

class DoctorProfileNotCompleteWidgets extends StatelessWidget {
  const DoctorProfileNotCompleteWidgets({super.key, required this.user});
  final DoctorUserModel? user;
  @override
  Widget build(BuildContext context) {
    context.watch<UserInfoCubit>();
    return Column(
      children: [
        SizedBox(height: 15.h),
        ProfileIncompleteWidget(
          title: 'Your Main Professional Information Incomplete',
          isVisible: user?.doctor == null,
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutesNames.doctorForm, arguments: {'create': true});
          },
        ),
        Visibility(
          visible: user?.doctor != null,
          child: Column(
            children: [
              ProfileIncompleteWidget(
                title: 'Your Additional Professional Information Incomplete',
                message:
                    "Tell us more about your work experience so we can connect you with the best locum opportunities.",
                isVisible: user?.doctor?.doctorInfo == null,
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutesNames.doctorInfoForm, arguments: {'create': true});
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
              BlocProvider(
                create: (context) => CreateDoctorDocumentsCubit(serviceLocator()),
                child: Builder(
                  builder: (context) {
                    return AddDoctorInfoWidget(
                      title: 'No Documents added',
                      message:
                          "Upload your related documents to help healthcare providers find what they need.",
                      buttonContent: "Add Document",
                      isVisible: user?.doctor?.doctorDocuments?.isEmpty ?? true,
                      onTap: () async {
                        CreateDoctorDocumentParams? params = await updateOrCreateDocument(context);
                        if (params == null) return;
                        context.read<CreateDoctorDocumentsCubit>().createDoctorDocument(
                          params: params,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

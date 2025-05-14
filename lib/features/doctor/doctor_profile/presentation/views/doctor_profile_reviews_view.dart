import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/comments/presentation/views/comment_view.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';

class DoctorProfileReviewsView extends StatefulWidget {
  const DoctorProfileReviewsView({super.key});

  @override
  State<DoctorProfileReviewsView> createState() => _DoctorProfileReviewsViewState();
}

class _DoctorProfileReviewsViewState extends State<DoctorProfileReviewsView> {
  late DoctorUserModel? doctorUserModel;
  late DoctorModel? doctorModel;
  @override
  void initState() {
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorModel = doctorUserModel?.doctor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Your Profile Reviews',
      drawer: const DefaultDoctorDrawer(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (doctorUserModel?.id != null)
              CommentView(
                commentableType: 'doctor',
                commentableId: (doctorUserModel?.id)!,
                showLeaveReply: false,
              ),
          ],
        ),
      ),
    );
  }
}

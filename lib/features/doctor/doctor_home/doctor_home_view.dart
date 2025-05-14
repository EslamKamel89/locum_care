import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_home/widgets/hero_section.dart';
import 'package:locum_care/features/doctor/doctor_home/widgets/testimonials_widget.dart';
import 'package:locum_care/features/doctor/doctor_home/widgets/why_choose_us_widget.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late final DoctorUserModel? doctorUserModel;

  @override
  void initState() {
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // serviceLocator<CommentRepo>()
    //     .getCommentByParentType(params: GetCommentParams(parent: 'doctor', limit: 10, page: 1));
    return MainScaffold(
      appBarTitle: '',
      hideAppBar: true,
      bottomNavigationBar: doctorBottomNavigationBar,
      drawer: const DefaultDoctorDrawer(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            HeroSection(doctorUserModel: doctorUserModel),
            const SizedBox(height: 20),
            const WhyChooseUsWidget(),
            const SizedBox(height: 20),
            const TestimonialsWidget(),
          ],
        ),
      ),
    );
  }
}

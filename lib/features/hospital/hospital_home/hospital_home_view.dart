import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';

class HospitalHomeScreen extends StatefulWidget {
  const HospitalHomeScreen({super.key});

  @override
  State<HospitalHomeScreen> createState() => _HospitalHomeScreenState();
}

class _HospitalHomeScreenState extends State<HospitalHomeScreen> {
  @override
  void initState() {
    // context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HospitalUserModel? user = context.read<UserInfoCubit>().state.hospitalUserModel;
    pr(user, 'user');
    return MainScaffold(
      appBarTitle: 'Hospital Home Page',
      bottomNavigationBar: hospitalBottomNavigationBar,
      drawer: const DefaultHospitalDrawer(),
      child: ElevatedButton(
        child: const Text('Profile'),
        onPressed: () {
          hospitalBottomNavigationBar.navigateTo(2);
        },
      ),
    );
  }
}

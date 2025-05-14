import 'package:flutter/material.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/repos/doctor_job_application_repo.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/widgets/job_applications_widget.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/widgets/status_filter_widget.dart';

class DoctorAllJobApplicationView extends StatefulWidget {
  const DoctorAllJobApplicationView({super.key});

  @override
  State<DoctorAllJobApplicationView> createState() => _DoctorAllJobApplicationViewState();
}

class _DoctorAllJobApplicationViewState extends State<DoctorAllJobApplicationView> {
  @override
  Widget build(BuildContext context) {
    serviceLocator<DoctorJobApplicationRepo>().showAllJobApplication(limit: 10, page: 1);
    return const MainScaffold(
      appBarTitle: 'My Applications',
      drawer: DefaultDoctorDrawer(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.search), SizedBox(width: 20), StatusFilterWidget()],
          ),
          Expanded(child: JobApplicationsWidget()),
        ],
      ),
    );
  }
}

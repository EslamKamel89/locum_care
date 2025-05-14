import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/widgets/no_data_widget.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/cubits/doctor_job_application/doctor_job_application_cubit.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/widgets/job_application_widget.dart';

class JobApplicationsWidget extends StatefulWidget {
  const JobApplicationsWidget({super.key});

  @override
  State<JobApplicationsWidget> createState() => _JobApplicationsWidgetState();
}

class _JobApplicationsWidgetState extends State<JobApplicationsWidget> {
  late final DoctorJobApplicationCubit controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controller = context.read<DoctorJobApplicationCubit>();
    controller.showAllJobApplication();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double scrollPosition = _scrollController.position.pixels;
    if (scrollPosition > maxExtent * 0.9) {
      controller.showAllJobApplication();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorJobApplicationCubit, DoctorJobApplicationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.jobApplicationDetailsResponse?.data?.isEmpty == true &&
            state.responseType == ResponseEnum.success) {
          return const NoDataWidget();
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: (state.jobApplicationDetailsResponse?.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index < (state.jobApplicationDetailsResponse?.data?.length ?? 0)) {
              final JobApplicationDetailsModel? model =
                  state.jobApplicationDetailsResponse?.data?[index];
              if (model == null) return const SizedBox();
              return JobApplicationWidget(jobApplicationDetailsModel: model);
            }

            return state.responseType == ResponseEnum.loading
                ? const JobApplicationLoadingWidget()
                : const SizedBox();
          },
        );
      },
    );
  }
}

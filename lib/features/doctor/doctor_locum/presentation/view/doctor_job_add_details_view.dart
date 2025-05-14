import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/comments/presentation/views/comment_view.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/apply_to_job_add/apply_to_job_add_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/show_job_add/show_job_add_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/view/widgets/apply_to_job_popup.dart';

class DoctorJobAddDetailsView extends StatefulWidget {
  final int id;

  const DoctorJobAddDetailsView({super.key, required this.id});

  @override
  State<DoctorJobAddDetailsView> createState() => _DoctorJobAddDetailsViewState();
}

class _DoctorJobAddDetailsViewState extends State<DoctorJobAddDetailsView> {
  late final ShowJobAddCubit controller;
  @override
  void initState() {
    controller = context.read<ShowJobAddCubit>();
    controller.showJobAdd(jobAddId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowJobAddCubit, ShowJobAddState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final JobAddModel? jobAddModel = state.jobAddModel;
        return MainScaffold(
          appBarTitle: 'Job Add Details',
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<ApplyToJobAddCubit, ApplyToJobAddState>(
                  listener: (context, state) {
                    if (state.responseType == ResponseEnum.success) {
                      // Navigator.of(context).pop();
                      doctorBottomNavigationBar.navigateTo(1);
                    }
                  },
                  builder: (context, applyToJobAddState) {
                    final applyToJobAddCubit = context.read<ApplyToJobAddCubit>();
                    return _titleAndApplyBtn(jobAddModel, state, () async {
                      if (jobAddModel?.id == null) return;
                      /* application content
                                    {
                                      'applyStatus': true,
                                      'notes': notesController.text,
                                    }
                                     */
                      final Map<String, dynamic>? application =
                          await showDialog<Map<String, dynamic>?>(
                            context: context,
                            builder: (context) {
                              return ApplyToJobPopup(jobAddId: (jobAddModel?.id)!);
                            },
                          );
                      if (application == null || !application['applyStatus']) return;
                      pr(application, 'application');
                      if (jobAddModel?.id == null) return;
                      applyToJobAddCubit.applyJobAdd(
                        jobAddId: (jobAddModel?.id)!,
                        notes: application['notes'],
                      );
                    });
                  },
                ),
                _sizer(),
                _buildInfoRow('Specialty', jobAddModel?.specialty?.name, state),
                _buildInfoRow('Job Info', jobAddModel?.jobInfo?.name, state),
                _buildInfoRow('Job Type', jobAddModel?.jobType, state),
                _buildSection('Location', jobAddModel?.location, state),
                _buildSection('Description', jobAddModel?.description, state),
                _buildSection('Responsibilities', jobAddModel?.responsibilities, state),
                _buildSection('Qualifications', jobAddModel?.qualifications, state),
                _buildSection('Experience Required', jobAddModel?.experienceRequired, state),
                _buildInfoRow(
                  'Pay Rate',
                  '\$${jobAddModel?.salaryMin} - \$${jobAddModel?.salaryMax}',
                  state,
                ),
                _buildSection('Benefits', jobAddModel?.benefits, state),
                _buildInfoRow('Shift Hours', jobAddModel?.workingHours, state),
                _buildInfoRow(
                  'Application Deadline',
                  formatStrDateToAmerican(jobAddModel?.applicationDeadline),
                  state,
                ),
                _buildSection('Required Documents', jobAddModel?.requiredDocuments, state),
                _buildInfoRow(
                  'Date Published',
                  formatStrDateToAmerican(jobAddModel?.createdAt),
                  state,
                ),
                _wrapWithLabel(
                  'Required Languages',
                  (jobAddModel?.langs ?? []).map((lang) => lang.name ?? '').toList(),
                  state,
                ),
                // _wrapWithLabel(
                //     'Required Skills',
                //     (jobAddModel?.skills ?? [])
                //         .map((skill) => skill.name ?? '')
                //         .toList(),
                //     state),
                CommentView(commentableType: 'jobAdd', commentableId: widget.id),
                // ReviewList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _titleAndApplyBtn(
    JobAddModel? jobAddModel,
    ShowJobAddState state,
    void Function()? handleApply,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headLine(jobAddModel?.title, state),
              _headLine(jobAddModel?.hospital?.facilityName, state),
              InkWell(
                onTap: () {
                  if (jobAddModel?.hospitalId == null) return;
                  Navigator.of(context).pushNamed(
                    AppRoutesNames.viewHospitalProfile,
                    arguments: {'id': jobAddModel?.hospitalId},
                  );
                },
                child: Text(
                  'View Health Care Provider Profile',
                  style: TextStyle(
                    color: context.secondaryHeaderColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: handleApply,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(context.secondaryHeaderColor),
            ),
            child: const Text('Apply', style: TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Widget _sizer() {
    return const SizedBox(height: 16);
  }

  Widget _wrapWithLabel(String title, List<String> data, ShowJobAddState state) {
    if (data.isEmpty && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_title(title), const SizedBox(height: 10), BadgeWrap(items: data), _sizer()],
    );
  }

  Widget _headLine(String? title, ShowJobAddState state) {
    if (title == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Text(
      title ?? '',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.primaryColor),
    );
  }

  Widget _buildSection(String? title, String? content, ShowJobAddState state) {
    if (content == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_title(title ?? ''), _content(content ?? ''), _sizer()],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: context.secondaryHeaderColor,
      ),
    );
  }

  Widget _content(String content) {
    return Text(content, style: const TextStyle(fontSize: 14));
  }

  // Helper to build key-value rows
  Widget _buildInfoRow(String label, String? value, ShowJobAddState state) {
    if (value == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(label),
          Expanded(child: Text(value ?? '', textAlign: TextAlign.end, style: const TextStyle())),
        ],
      ),
    );
  }
}

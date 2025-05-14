import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/widgets/job_application_widget.dart';

class DoctorJobApplicationDetailsView extends StatefulWidget {
  const DoctorJobApplicationDetailsView({super.key, required this.jobApplicationModel});
  final JobApplicationDetailsModel jobApplicationModel;

  @override
  State<DoctorJobApplicationDetailsView> createState() => _DoctorJobApplicationDetailsViewState();
}

class _DoctorJobApplicationDetailsViewState extends State<DoctorJobApplicationDetailsView> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Job Add Details',
      drawer: const DefaultDoctorDrawer(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleAndStatus(widget.jobApplicationModel),
            _sizer(),
            _buildInfoRow('Specialty', widget.jobApplicationModel.jobAdd?.specialty?.name),
            _buildInfoRow('Job Info', widget.jobApplicationModel.jobAdd?.jobInfo?.name),
            _buildInfoRow('Job Type', widget.jobApplicationModel.jobAdd?.jobType),
            _buildSection('Location', widget.jobApplicationModel.jobAdd?.location),
            _buildSection('Description', widget.jobApplicationModel.jobAdd?.description),
            _buildSection('Responsibilities', widget.jobApplicationModel.jobAdd?.responsibilities),
            _buildSection('Qualifications', widget.jobApplicationModel.jobAdd?.qualifications),
            _buildSection(
              'Experience Required',
              widget.jobApplicationModel.jobAdd?.experienceRequired,
            ),
            _buildInfoRow(
              'Salary Range',
              '\$${widget.jobApplicationModel.jobAdd?.salaryMin} - \$${widget.jobApplicationModel.jobAdd?.salaryMax}',
            ),
            _buildSection('Benefits', widget.jobApplicationModel.jobAdd?.benefits),
            _buildInfoRow('Working Hours', widget.jobApplicationModel.jobAdd?.workingHours),
            _buildInfoRow(
              'Application Deadline',
              formatStrDateToAmerican(widget.jobApplicationModel.jobAdd?.applicationDeadline),
            ),
            _buildSection(
              'Required Documents',
              widget.jobApplicationModel.jobAdd?.requiredDocuments,
            ),
            _buildInfoRow(
              'Published At',
              formatStrDateToAmerican(widget.jobApplicationModel.jobAdd?.createdAt),
            ),
            _wrapWithLabel(
              'Required Languages',
              (widget.jobApplicationModel.jobAdd?.langs ?? [])
                  .map((lang) => lang.name ?? '')
                  .toList(),
            ),
            _wrapWithLabel(
              'Required Skills',
              (widget.jobApplicationModel.jobAdd?.skills ?? [])
                  .map((skill) => skill.name ?? '')
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleAndStatus(JobApplicationDetailsModel? jobApplicationDetailsModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headLine(jobApplicationDetailsModel?.jobAdd?.title),
              _headLine(jobApplicationDetailsModel?.jobAdd?.hospital?.facilityName),
            ],
          ),
        ),
        Expanded(flex: 2, child: StatusWidget(status: jobApplicationDetailsModel?.status ?? '')),
      ],
    );
  }

  Widget _sizer() {
    return const SizedBox(height: 16);
  }

  Widget _wrapWithLabel(String title, List<String> data) {
    if (data.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_title(title), const SizedBox(height: 10), BadgeWrap(items: data), _sizer()],
    );
  }

  Widget _headLine(String? title) {
    if (title == null) {
      return const SizedBox();
    }
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.primaryColor),
    );
  }

  Widget _buildSection(String? title, String? content) {
    if (content == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_title(title ?? ''), _content(content), _sizer()],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: context.primaryColor.withRed(50),
      ),
    );
  }

  Widget _content(String content) {
    return Text(content, style: const TextStyle(fontSize: 14));
  }

  // Helper to build key-value rows
  Widget _buildInfoRow(String label, String? value) {
    if (value == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(label),
          Expanded(child: Text(value, textAlign: TextAlign.end, style: const TextStyle())),
        ],
      ),
    );
  }
}

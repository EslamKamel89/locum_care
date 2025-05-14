import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/widgets/custom_fading_widget.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/models/job_application_details_model.dart';

class JobApplicationWidget extends StatelessWidget {
  const JobApplicationWidget({super.key, required this.jobApplicationDetailsModel});
  final JobApplicationDetailsModel jobApplicationDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobApplicationDetailsModel.jobAdd?.hospital?.facilityName ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jobApplicationDetailsModel.jobAdd?.title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialty: ${jobApplicationDetailsModel.jobAdd?.specialty?.name ?? ''}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Job Title: ${jobApplicationDetailsModel.jobAdd?.jobInfo?.name ?? ''}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusWidget(status: jobApplicationDetailsModel.status ?? ''),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.doctorJobApplicationDetailsView,
                      arguments: {'model': jobApplicationDetailsModel},
                    );
                  },
                  child: Text(
                    'Show Details',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            // Text(
            //   jobApplicationDetailsModel.jobAdd?.description ?? '',
            //   maxLines: 3,
            //   overflow: TextOverflow.ellipsis,
            //   style: const TextStyle(
            //     fontSize: 14,
            //   ),
            // ),
            // const SizedBox(height: 12),
            // Row(
            //   children: [
            //     Chip(
            //       label: Text(jobApplicationDetailsModel.jobAdd?.jobType ?? ''),
            //       backgroundColor: context.primaryColor.withOpacity(0.1),
            //       labelStyle: TextStyle(
            //         color: context.primaryColor,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: Text(
            //         jobApplicationDetailsModel.jobAdd?.location ?? '',
            //         style: const TextStyle(
            //           fontSize: 14,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 12),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(
                  formatStrDateToAmerican(jobApplicationDetailsModel.jobAdd?.createdAt) ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  final String status; // "pending", "accepted", "rejected"

  const StatusWidget({super.key, required this.status});

  // Method to get colors and icons based on the status
  Map<String, dynamic> _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return {'color': Colors.green, 'icon': Icons.check_circle, 'text': 'Accepted'};
      case 'rejected':
        return {'color': Colors.red, 'icon': Icons.cancel, 'text': 'Rejected'};
      case 'pending':
      default:
        return {'color': Colors.orange, 'icon': Icons.hourglass_empty, 'text': 'Pending'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: statusStyle['color'].withOpacity(0.2), // Light background
        border: Border.all(color: statusStyle['color']),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusStyle['icon'], color: statusStyle['color'], size: 24),
          const SizedBox(width: 8.0),
          Text(
            statusStyle['text'],
            style: TextStyle(
              color: statusStyle['color'],
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class JobApplicationLoadingWidget extends StatelessWidget {
  const JobApplicationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: Column(
        children: [_buildCard(), _buildCard(), _buildCard(), _buildCard(), _buildCard()],
      ),
    );
  }

  Widget _buildCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(0.6),
            const SizedBox(height: 8),
            _buildRow(0.8),
            const SizedBox(height: 8),
            _buildRow(0.5),
            const SizedBox(height: 12),
            _buildRow(0.8, 3),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_buildRow(0.3, 2), _buildRow(0.3, 2)],
            ),
            const SizedBox(height: 12),
            _buildRow(),
            const SizedBox(height: 12),
            _buildRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildRow([double widthRatio = 1, int numberOfLines = 1]) {
    if (widthRatio > 1) {
      widthRatio = 1;
    }
    return Container(
      height: 20.0 * numberOfLines,
      width: (navigatorKey.currentContext?.width ?? 0) * widthRatio,
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
    );
  }
}

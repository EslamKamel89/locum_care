import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/widgets/custom_fading_widget.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';

class JobAddWidget extends StatelessWidget {
  final JobAddModel jobAddModel;

  const JobAddWidget({super.key, required this.jobAddModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      shadowColor: context.secondaryHeaderColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobAddModel.hospital?.facilityName ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jobAddModel.title ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.secondaryHeaderColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialty: ${jobAddModel.specialty?.name ?? ''}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Job Title: ${jobAddModel.jobInfo?.name ?? ''}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Text(
              jobAddModel.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text(jobAddModel.jobType ?? ''),
                  backgroundColor: context.primaryColor,
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              jobAddModel.location ?? '',
              style: TextStyle(fontSize: 14, color: context.secondaryHeaderColor),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutesNames.doctorJobDetailsScreen,
                  arguments: {'id': jobAddModel.id},
                );
              },
              child: Text(
                'Show Details',
                style: TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  color: context.secondaryHeaderColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                if (jobAddModel.createdAt != null)
                  Text(
                    // (jobAddModel.createdAt ?? '').split('T').first,
                    formatStrDateToAmerican(jobAddModel.createdAt)!,
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

class JobAdLoadingWidget extends StatelessWidget {
  const JobAdLoadingWidget({super.key});

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

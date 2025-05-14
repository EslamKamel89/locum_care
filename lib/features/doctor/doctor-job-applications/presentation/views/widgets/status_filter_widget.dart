import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/cubits/doctor_job_application/doctor_job_application_cubit.dart';

class StatusFilterWidget extends StatefulWidget {
  const StatusFilterWidget({super.key});

  @override
  StatusFilterWidgetState createState() => StatusFilterWidgetState();
}

class StatusFilterWidgetState extends State<StatusFilterWidget> {
  String? _selectedStatus;
  final List<String> filters = [
    'All Applications',
    'Accepted Applications',
    'Pending Applications',
    'Rejected Applications',
  ];
  @override
  void initState() {
    super.initState();
    _selectedStatus = filters.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedStatus,
      onChanged: (newValue) {
        setState(() {
          _selectedStatus = newValue;
        });
        String? status;
        if (newValue == filters[0]) {
          status = null;
        } else if (newValue == filters[1]) {
          status = 'accepted';
        } else if (newValue == filters[2]) {
          status = 'pending';
        } else if (newValue == filters[3]) {
          status = 'rejected';
        }
        context.read<DoctorJobApplicationCubit>().resetState();
        context.read<DoctorJobApplicationCubit>().showAllJobApplication(status);
      },
      items:
          filters.map<DropdownMenuItem<String>>((String status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status, style: const TextStyle(fontSize: 16.0)),
            );
          }).toList(),
    );
  }
}

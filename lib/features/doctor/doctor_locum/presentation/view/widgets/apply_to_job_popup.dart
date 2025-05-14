import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class ApplyToJobPopup extends StatefulWidget {
  const ApplyToJobPopup({super.key, required this.jobAddId});
  final int jobAddId;

  @override
  State<ApplyToJobPopup> createState() => _ApplyToJobPopupState();
}

class _ApplyToJobPopupState extends State<ApplyToJobPopup> {
  final TextEditingController notesController = TextEditingController();
  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop({'applyStatus': false});
              },
              child: const Icon(Icons.close),
            ),
          ),
          const Text(
            "Share what makes you the ideal candidate for this role.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Highlight the qualities and experiences that make you perfect for this job."),
          CustomTextField(
            'Notes',
            notesController,
            "Describe how your skills and background align with the job requirements.",
            showMulitLine: true,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop({'applyStatus': true, 'notes': notesController.text});
            },
            child: const Text('Save Application'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

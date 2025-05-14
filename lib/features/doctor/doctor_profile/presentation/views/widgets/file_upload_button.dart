import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/launch_url.dart';

class FileUploadButton extends StatefulWidget {
  const FileUploadButton({super.key, this.fileUrl, required this.onFileSelected});

  final String? fileUrl;
  final Future<File?> Function() onFileSelected;
  @override
  State<FileUploadButton> createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {
  File? selectedFile;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Stand out by uploading your CV. It will help us find the perfect job for you.'),
        Row(
          children: [
            InkWell(
              onTap: () async {
                selectedFile = await widget.onFileSelected();
                setState(() {});
              },
              child: Text(
                selectedFile == null ? 'Upload CV' : 'Change CV',
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 16),
            if (selectedFile != null)
              Expanded(
                child: Text(
                  'File: ${selectedFile?.path.split('/').last}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        if (widget.fileUrl != null)
          InkWell(
            onTap: () {
              launchUrl(widget.fileUrl!);
            },
            child: Text(
              'View Last Saved CV',
              style: TextStyle(
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}

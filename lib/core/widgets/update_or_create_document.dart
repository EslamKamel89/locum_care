import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locum_care/core/heleprs/pick_file.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

Future<CreateDoctorDocumentParams?> updateOrCreateDocument(BuildContext context) async {
  final CreateDoctorDocumentParams? docData =
      await showModalBottomSheet<CreateDoctorDocumentParams>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return const UploadDocumentWidget();
        },
      );
  return docData;
}

class UploadDocumentWidget extends StatefulWidget {
  const UploadDocumentWidget({super.key});

  @override
  State<UploadDocumentWidget> createState() => _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends State<UploadDocumentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _docTypeController = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  File? selectedFile;
  final FocusNode _focusNode = FocusNode();
  bool showFileErrorMsg = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Upload Document',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text('Document Name:', style: TextStyle(fontSize: 14)),
              TextFormField(
                controller: _fileNameController,
                // focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Enter document name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                validator:
                    (input) => valdiator(input: input, label: 'Document Name', isRequired: true),
              ),
              const SizedBox(height: 20),
              const Text('Document Type:', style: TextStyle(fontSize: 14)),
              TextFormField(
                controller: _docTypeController,
                // focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Document type (e.g., License, Accreditation)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                validator:
                    (input) => valdiator(input: input, label: 'Document Type', isRequired: true),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  selectedFile = await pickFile();
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_file, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Choose File', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                selectedFile == null
                    ? 'No file selected'
                    : 'You selected ${_getFileName(selectedFile!)}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              if (showFileErrorMsg)
                const Text(
                  'Please Upload pdf or doc file',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  _focusNode.unfocus();
                  if (selectedFile == null) {
                    setState(() {
                      showFileErrorMsg = true;
                    });
                    return;
                  } else {
                    setState(() {
                      showFileErrorMsg = false;
                    });
                  }
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(
                      CreateDoctorDocumentParams(
                        name: _fileNameController.text,
                        file: selectedFile,
                        type: _docTypeController.text,
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFileName(File file) {
    return file.path.split('/').last;
  }
}

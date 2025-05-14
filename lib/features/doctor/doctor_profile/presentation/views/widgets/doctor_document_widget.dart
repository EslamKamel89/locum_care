// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/delete_doctor_documents/delete_doctor_documents_cubit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDocumentWidget extends StatefulWidget {
  const DoctorDocumentWidget({super.key, required this.doctorDocumentModel});
  final DoctorDocumentModel doctorDocumentModel;
  @override
  State<DoctorDocumentWidget> createState() => _DoctorDocumentWidgetState();
}

class DoctorDocumentOption {
  final String action;
  final Icon icon;
  DoctorDocumentOption({required this.action, required this.icon});
}

class _DoctorDocumentWidgetState extends State<DoctorDocumentWidget> {
  DoctorDocumentOption? selectedValue;
  List<DoctorDocumentOption> options = [
    DoctorDocumentOption(action: 'View', icon: Icon(MdiIcons.viewCarouselOutline)),
    DoctorDocumentOption(action: 'Delete', icon: const Icon(Icons.delete, color: Colors.red)),
  ];
  @override
  void initState() {
    // selectedValue = options.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteDoctorDocumentsCubit(serviceLocator()),
      child: BlocConsumer<DeleteDoctorDocumentsCubit, DeleteDoctorDocumentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.doctorDocumentModel.type ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  // width: 100,
                  child: DropdownButton<DoctorDocumentOption>(
                    items:
                        options
                            .map(
                              (option) => DropdownMenuItem(
                                value: option,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(option.action),
                                    // const SizedBox(width: 5),
                                    option.icon,
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) async {
                      setState(() {
                        selectedValue = value ?? options.first;
                      });
                      if (value == null) return;
                      if (value.action == options[0].action) {
                        await launchUrl(
                          Uri.parse(
                            "${EndPoint.imgBaseUrl}${widget.doctorDocumentModel.file ?? ''}",
                          ),
                        );
                      } else if (value.action == options[1].action) {
                        final controller = context.read<DeleteDoctorDocumentsCubit>();
                        if (widget.doctorDocumentModel.id == null) return;
                        controller.deleteDoctorDocument(id: (widget.doctorDocumentModel.id)!);
                      }
                      setState(() {
                        selectedValue = null;
                      });
                    },
                    hint: Icon(MdiIcons.menuOpen),
                    value: selectedValue,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

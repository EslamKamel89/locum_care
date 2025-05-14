// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
// import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
// import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';

// class DoctorDocumentsForm extends StatefulWidget {
//   const DoctorDocumentsForm({super.key, required this.create});
//   final bool create;

//   @override
//   State<DoctorDocumentsForm> createState() => _DoctorDocumentsFormState();
// }

// class _DoctorDocumentsFormState extends State<DoctorDocumentsForm> {
//   final TextEditingController _documentTypeController = TextEditingController();
//   File? selectedFile;
//   // late final DoctorInfoCubit controller;
//   late DoctorUserModel? doctorUserModel;
//   late DoctorInfoModel? doctorInfoModel;
//   @override
//   void initState() {
//     // controller = context.read<DoctorInfoCubit>();
//     doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
//     doctorInfoModel = doctorUserModel?.doctor?.doctorInfo;
//     _initializeTextFieldIfUpdating();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }

//   void _initializeTextFieldIfUpdating() {
//     if (widget.create || doctorUserModel == null) return;
//     _documentTypeController.text = doctorUserModel?.doctor.doctorDocuments ?? '';
//   }
// }

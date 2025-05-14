import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/heleprs/if_str_empty_return_null.dart';
import 'package:locum_care/core/heleprs/parse_int.dart';
import 'package:locum_care/core/heleprs/pick_file.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/state/state_cubit.dart';
import 'package:locum_care/features/common_data/cubits/university/university_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/doctor_info/doctor_info_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/file_upload_button.dart';

class DoctorInfoForm extends StatefulWidget {
  const DoctorInfoForm({super.key, required this.create});
  final bool create;
  @override
  State<DoctorInfoForm> createState() => DoctorInfoFormState();
}

class DoctorInfoFormState extends State<DoctorInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseStateController = TextEditingController();
  final TextEditingController _licenseIssueDateController = TextEditingController();
  final TextEditingController _licenseExpireDateController = TextEditingController();
  final TextEditingController _highestDegreeController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _graduationYearController = TextEditingController();
  final TextEditingController _workExperienceController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  // Date fields
  DateTime? licenseIssueDate;
  DateTime? licenseExpiryDate;
  String? _selectedUniversity;

  File? selectedFile;
  late final DoctorInfoCubit controller;
  late DoctorUserModel? doctorUserModel;
  late DoctorInfoModel? doctorInfoModel;
  @override
  void initState() {
    controller = context.read<DoctorInfoCubit>();
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorInfoModel = doctorUserModel?.doctor?.doctorInfo;
    _initializeTextFieldIfUpdating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorInfoCubit, DoctorInfoState>(
      listener: (context, state) {
        if (state.responseType == ResponseEnum.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: 'Professional Information',
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    'License Number *',
                    _licenseNumberController,
                    'Enter license number',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'License Number', isRequired: true);
                    },
                  ),
                  // CustomTextField('License State', _licenseStateController, 'Enter license state'),
                  BlocProvider(
                    create: (context) => StateCubit(serviceLocator())..fetchStates(),
                    child: BlocBuilder<StateCubit, StateState>(
                      builder: (context, state) {
                        return CustomTextFormFieldWithSuggestions(
                          label: 'License State *',
                          suggestions:
                              (state.stateModels ?? [])
                                  .map((university) => university.name ?? '')
                                  .toList(),
                          onSelected: (String state) {},
                          controller: _licenseStateController,
                          validator: (String? value) {
                            return valdiator(
                              input: value,
                              label: 'License State',
                              isRequired: true,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  CustomDateField(
                    label: 'License Issue Date *',
                    initialDate: licenseIssueDate,
                    onDateSubmit: (date) => licenseIssueDate = date,
                    textEditingController: _licenseIssueDateController,
                    validator: (String? value) {
                      return valdiator(input: value, label: 'License Issue Date', isRequired: true);
                    },
                  ),
                  CustomDateField(
                    label: 'License Expiry Date *',
                    initialDate: licenseExpiryDate,
                    onDateSubmit: (date) => licenseExpiryDate = date,
                    textEditingController: _licenseExpireDateController,
                    validator: (String? value) {
                      return valdiator(input: value, label: 'License Issue Date', isRequired: true);
                    },
                  ),
                  BlocProvider(
                    create: (context) => UniversityCubit(serviceLocator())..fetchUniversities(),
                    child: BlocBuilder<UniversityCubit, UniversityState>(
                      builder: (context, state) {
                        return CustomTextFormFieldWithSuggestions(
                          label: 'University Name',
                          suggestions:
                              (state.universityModels ?? [])
                                  .map((university) => university.name ?? '')
                                  .toList(),
                          onSelected: (String university) {
                            _selectedUniversity = university;
                          },
                          controller: _universityController,
                        );
                      },
                    ),
                  ),

                  CustomTextField(
                    'Highest Degree *',
                    _highestDegreeController,
                    'Enter highest degree',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Highest Degree', isRequired: true);
                    },
                  ),
                  CustomTextField(
                    'Residency  *',
                    _fieldOfStudyController,
                    'Enter Residency',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Residency', isRequired: true);
                    },
                  ),
                  CustomTextField(
                    'Graduation Year',
                    _graduationYearController,
                    'Enter graduation year',
                    inputType: TextInputType.number,
                  ),
                  CustomTextField(
                    'Work Experience',
                    _workExperienceController,
                    'Enter work experience',
                    showMulitLine: true,
                  ),
                  CustomBiographyForm(controller: _biographyController),
                  FileUploadButton(
                    onFileSelected: () async {
                      selectedFile = await pickFile();
                      return selectedFile;
                    },
                    fileUrl: doctorInfoModel?.cv,
                    // fileUrl: 'https://www.google.com/',
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _sendRequest();
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(width: 10),
                      state.responseType == ResponseEnum.loading
                          ? const Align(
                            alignment: Alignment.centerLeft,
                            child: CircularProgressIndicator(),
                          )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _sendRequest() {
    if (_formKey.currentState!.validate()) {
      final params = pr(
        DoctorInfoParams(
          professionalLicenseNumber: ifStrEmptyReturnNull(_licenseNumberController.text),
          licenseState: ifStrEmptyReturnNull(_licenseStateController.text),
          licenseIssueDate:
              licenseIssueDate != null
                  ? formatDateForApi(licenseIssueDate!)
                  : doctorInfoModel?.licenseIssueDate,
          licenseExpiryDate:
              licenseExpiryDate != null
                  ? formatDateForApi(licenseExpiryDate!)
                  : doctorInfoModel?.licenseExpiryDate,
          universityName: ifStrEmptyReturnNull(_universityController.text),
          highestDegree: ifStrEmptyReturnNull(_highestDegreeController.text),
          fieldOfStudy: ifStrEmptyReturnNull(_fieldOfStudyController.text),
          graduationYear: parseInt(ifStrEmptyReturnNull(_graduationYearController.text)),
          workExperience: ifStrEmptyReturnNull(_workExperienceController.text),
          cv: selectedFile,
          biography: ifStrEmptyReturnNull(_biographyController.text),
        ),
        'DoctorInfoParams',
      );
      controller.updateOrCreateDoctorInfo(
        params: params,
        create: widget.create,
        id: doctorInfoModel?.id,
      );
    }
  }

  void _initializeTextFieldIfUpdating() {
    if (widget.create || doctorInfoModel == null) return;
    _licenseNumberController.text = doctorInfoModel?.professionalLicenseNumber ?? '';
    _licenseStateController.text = doctorInfoModel?.licenseState ?? '';
    _highestDegreeController.text = doctorInfoModel?.highestDegree ?? '';
    _fieldOfStudyController.text = doctorInfoModel?.fieldOfStudy ?? '';
    _graduationYearController.text = doctorInfoModel?.graduationYear?.toString() ?? '';
    _workExperienceController.text = doctorInfoModel?.workExperience ?? '';
    _biographyController.text = doctorInfoModel?.biography ?? '';
    _universityController.text = doctorInfoModel?.university?.name ?? '';
    _licenseIssueDateController.text =
        formatStrDateToAmerican(doctorInfoModel?.licenseIssueDate) ?? '';
    _licenseExpireDateController.text =
        formatStrDateToAmerican(doctorInfoModel?.licenseExpiryDate) ?? '';
  }
}

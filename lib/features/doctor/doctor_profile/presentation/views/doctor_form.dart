import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/address_form.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/dropdown_widget.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/job_info/job_info_cubit.dart';
import 'package:locum_care/features/common_data/cubits/speciality/speciality_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/doctor/doctor_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/doctor_profile_image_view_upload.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/mulitple_lang_selector.dart';

class DoctorForm extends StatefulWidget {
  const DoctorForm({super.key, required this.create});
  final bool create;

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _jobInfoController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? dateOfBirth;
  String gender = 'male';
  File? selectedPhoto;
  bool willingToRelcoate = false;
  String selectdLangs = '';
  String selectdSkills = '';
  late DoctorUserModel? doctorUserModel;
  late DoctorModel? doctorModel;
  late DoctorCubit controller;
  @override
  void initState() {
    controller = context.read<DoctorCubit>();
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorModel = doctorUserModel?.doctor;
    _initializeTextFieldIfUpdating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state.responseType == ResponseEnum.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: 'Main Information',
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorProfileImageUploadView(
                    onImageSelected: (File file) {
                      selectedPhoto = file;
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocProvider(
                    create: (context) => SpecialtyCubit(serviceLocator())..fetchSpecialties(),
                    child: BlocBuilder<SpecialtyCubit, SpecialtyState>(
                      builder: (context, state) {
                        return CustomTextFormFieldWithSuggestions(
                          label: 'Specialty *',
                          suggestions:
                              (state.specialtyModels ?? [])
                                  .map((specilaity) => specilaity.name ?? '')
                                  .toList(),
                          onSelected: (String specialty) {
                            _jobInfoController.text = specialty;
                          },
                          controller: _jobInfoController,
                          validator: (String? value) {
                            return valdiator(input: value, label: 'Specialty', isRequired: true);
                          },
                        );
                      },
                    ),
                  ),
                  BlocProvider(
                    create: (context) => JobInfoCubit(serviceLocator())..fetchJobInfos(),
                    child: BlocBuilder<JobInfoCubit, JobInfoState>(
                      builder: (context, state) {
                        return CustomTextFormFieldWithSuggestions(
                          label: 'Job Title *',
                          suggestions:
                              (state.jobInfoModels ?? [])
                                  .map((jobInfo) => jobInfo.name ?? '')
                                  .toList(),
                          onSelected: (String specialty) {
                            _specialityController.text = specialty;
                          },
                          controller: _specialityController,
                          validator: (String? value) {
                            return valdiator(input: value, label: 'Job Title', isRequired: true);
                          },
                        );
                      },
                    ),
                  ),
                  CustomDateField(
                    label: 'Date of birth *',
                    initialDate: dateOfBirth,
                    onDateSubmit: (date) => dateOfBirth = date,
                    textEditingController: _dateOfBirthController,
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Date of birth', isRequired: true);
                    },
                  ),
                  const SizedBox(height: 5),
                  DropDownWidget(
                    options: const ['male', 'female'],
                    label: 'Gender *',
                    onSelect: (String option) {
                      gender = option;
                    },
                    initialValueIndex:
                        widget.create
                            ? null
                            : doctorModel?.gender == 'female'
                            ? 1
                            : 0,
                  ),

                  const SizedBox(height: 5),
                  CustomTextField(
                    'Address *',
                    _addressController,
                    'Enter Your Address',
                    readOnly: true,
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Address', isRequired: true);
                    },
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                            onClosing: () {},
                            builder: (_) {
                              return AddressFormWithDropdowns(
                                handleSaveAddress: (value) {
                                  setState(() {
                                    _addressController.text = value;
                                  });
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  // const SizedBox(height: 5),
                  CustomTextField(
                    'Phone *',
                    _phoneController,
                    'Enter Phone',
                    inputType: TextInputType.phone,
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Phone', isRequired: true);
                    },
                  ),
                  const SizedBox(height: 8),
                  DropDownWidget(
                    options: const ['Yes', 'No'],
                    label: 'Willing To Relocate *',
                    initialValueIndex:
                        widget.create
                            ? null
                            : doctorModel?.willingToRelocate == true
                            ? 0
                            : 1,
                    onSelect: (String option) {
                      willingToRelcoate = option == 'Yes';
                    },
                  ),
                  const SizedBox(height: 5),
                  MuiltipleValueLangsSelector(
                    onLangSelect: (String langs) {
                      selectdLangs = langs;
                    },
                  ),
                  // MuiltipleValueSkillSelector(
                  //   onSkillSelect: (String skills) {
                  //     selectdSkills = skills;
                  //   },
                  // ),
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 50),
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
        DoctorParams(
          specialtyName: _specialityController.text,
          jobInfoName: _jobInfoController.text,
          dateOfBirth:
              dateOfBirth != null ? formatDateForApi(dateOfBirth!) : doctorModel?.dateOfBirth,
          gender: gender,
          address: _addressController.text,
          phone: _phoneController.text,
          willingToRelocate: willingToRelcoate,
          langs: selectdLangs,
          skills: selectdSkills,
          photo: selectedPhoto,
        ),
        'DoctorParams',
      );
      controller.updateOrCreateDoctor(params: params, create: widget.create, id: doctorModel?.id);
    }
  }

  void _initializeTextFieldIfUpdating() {
    if (widget.create || doctorModel == null) return;
    _specialityController.text = doctorModel!.specialty?.name ?? '';
    _jobInfoController.text = doctorModel!.jobInfo?.name ?? '';
    _dateOfBirthController.text = formatStrDateToAmerican(doctorModel!.dateOfBirth) ?? '';
    _addressController.text = doctorModel!.address ?? '';
    _phoneController.text = doctorModel!.phone ?? '';
    willingToRelcoate = doctorModel?.willingToRelocate ?? false;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/cubits/hospital/hospital_cubit.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/views/widgets/hospital_profile_image_view_upload.dart';

class HospitalForm extends StatefulWidget {
  const HospitalForm({super.key, required this.create});
  final bool create;

  @override
  State<HospitalForm> createState() => _HospitalFormState();
}

class _HospitalFormState extends State<HospitalForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _serviceOfferedController = TextEditingController();
  final TextEditingController _numberOfBidsController = TextEditingController();
  final TextEditingController _websiteUrlController = TextEditingController();
  final TextEditingController _yearEstabishedController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  File? selectedPhoto;
  DateTime? yearEstablished;
  late HospitalUserModel? hospitalUserModel;
  late HospitalModel? hospitalModel;
  late HospitalCubit controller;
  @override
  void initState() {
    controller = context.read<HospitalCubit>();
    hospitalUserModel = context.read<UserInfoCubit>().state.hospitalUserModel;
    hospitalModel = hospitalUserModel?.hospital;
    _initializeTextFieldIfUpdating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalCubit, HospitalState>(
      listener: (context, state) {
        if (state.responseType == ResponseEnum.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: 'Main Information',
          drawer: const DefaultHospitalDrawer(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HospitalProfileImageUploadView(
                    onImageSelected: (File file) {
                      selectedPhoto = file;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    'Facility Name *',
                    _nameController,
                    'Enter Facility Name ',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Facility Name', isRequired: true);
                    },
                  ),
                  CustomTextField(
                    'Facility Type *',
                    _typeController,
                    'Enter Facility Type ',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Facility Type', isRequired: true);
                    },
                  ),
                  CustomTextField(
                    'Contact Person ',
                    _contactPersonController,
                    'Enter Contact Person ',
                  ),
                  CustomTextField(
                    'Contact Email ',
                    _contactEmailController,
                    'Enter Contact Email ',
                  ),
                  CustomTextField(
                    'Contact Phone ',
                    _contactPhoneController,
                    'Enter Contact Phone ',
                    inputType: TextInputType.phone,
                  ),
                  CustomTextField('Address ', _addressController, 'Enter Your Address'),
                  CustomTextField(
                    'Service Offereds',
                    _serviceOfferedController,
                    'Enter Service Offereds ',
                  ),
                  CustomTextField(
                    'Number OF Beds',
                    _numberOfBidsController,
                    'Enter Number OF Beds ',
                    inputType: TextInputType.number,
                  ),
                  CustomTextField('Website Url', _websiteUrlController, 'Enter Website Url '),
                  CustomTextField(
                    'Year Established',
                    _yearEstabishedController,
                    'Enter Year Established ',
                    inputType: TextInputType.number,
                  ),
                  CustomTextField('Website Url', _websiteUrlController, 'Enter Website Url '),
                  CustomTextField(
                    'Facility Overview',
                    _overviewController,
                    'Enter Facility Overview ',
                  ),
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
        HospitalParams(
          facilityName: _nameController.text,
          type: _typeController.text,
          contactPerson: _contactPersonController.text,
          contactEmail: _contactEmailController.text,
          contactPhone: _contactPhoneController.text,
          address: _addressController.text,
          servicesOffered: _serviceOfferedController.text,
          numberOfBeds:
              _numberOfBidsController.text != '' ? int.parse(_numberOfBidsController.text) : null,
          websiteUrl: _websiteUrlController.text,
          yearEstablished:
              _yearEstabishedController.text != ''
                  ? int.parse(_yearEstabishedController.text)
                  : null,
          overview: _overviewController.text,
          photo: selectedPhoto,
        ),
        'hospitalParams',
      );
      controller.updateOrCreateHospital(
        params: params,
        create: widget.create,
        id: hospitalModel?.id,
      );
    }
  }

  void _initializeTextFieldIfUpdating() {
    if (widget.create || hospitalModel == null) return;

    _nameController.text = hospitalModel!.facilityName ?? '';
    _typeController.text = hospitalModel!.type ?? '';
    _contactPersonController.text = hospitalModel!.contactPerson ?? '';
    _contactEmailController.text = hospitalModel!.contactEmail ?? '';
    _contactPhoneController.text = hospitalModel!.contactPhone ?? '';
    _addressController.text = hospitalModel!.address ?? '';
    _serviceOfferedController.text = hospitalModel!.servicesOffered ?? '';
    _numberOfBidsController.text = hospitalModel!.numberOfBeds?.toString() ?? '';
    _websiteUrlController.text = hospitalModel!.websiteUrl ?? '';
    _yearEstabishedController.text = hospitalModel!.yearEstablished?.toString() ?? '';
    _overviewController.text = hospitalModel!.overview ?? '';
  }
}

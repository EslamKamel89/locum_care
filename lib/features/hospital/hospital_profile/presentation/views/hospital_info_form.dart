import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/state/state_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/hospital_info_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/cubits/hospital-info/hospital_info_cubit.dart';

class HospitalInfoForm extends StatefulWidget {
  const HospitalInfoForm({super.key, required this.create});
  final bool create;

  @override
  State<HospitalInfoForm> createState() => _HospitalInfoFormState();
}

class _HospitalInfoFormState extends State<HospitalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseStateController = TextEditingController();
  final TextEditingController _licenseIssueDateController = TextEditingController();
  final TextEditingController _licenseExpireDateController = TextEditingController();
  final TextEditingController _operatingHoursController = TextEditingController();

  // Date fields
  DateTime? licenseIssueDate;
  DateTime? licenseExpiryDate;
  late final HospitalInfoCubit controller;
  late HospitalUserModel? hospitalUserModel;
  late HospitalInfoModel? hospitalInfoModel;
  @override
  void initState() {
    controller = context.read<HospitalInfoCubit>();
    hospitalUserModel = context.read<UserInfoCubit>().state.hospitalUserModel;
    hospitalInfoModel = hospitalUserModel?.hospital?.hospitalInfo;
    _initializeTextFieldIfUpdating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalInfoCubit, HospitalInfoState>(
      listener: (context, state) {
        if (state.responseType == ResponseEnum.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: 'Professional Information',
          drawer: const DefaultHospitalDrawer(),
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
                  CustomTextField(
                    'Operating Hours *',
                    _operatingHoursController,
                    'Enter Operating Hours',
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
        HospitalInfoParams(
          licenseNumber: _licenseNumberController.text,
          licenseState: _licenseStateController.text,
          licenseIssueDate: _licenseIssueDateController.text,
          licenseExpiryDate: _licenseExpireDateController.text,
          operatingHours: _operatingHoursController.text,
        ),
        'HospitalInfoParams',
      );
      controller.updateOrCreateHospitalInfo(
        params: params,
        create: widget.create,
        id: hospitalInfoModel?.id,
      );
    }
  }

  void _initializeTextFieldIfUpdating() {
    if (widget.create || hospitalInfoModel == null) return;
    _licenseNumberController.text = hospitalInfoModel?.licenseNumber ?? '';
    _licenseStateController.text = hospitalInfoModel?.licenseState ?? '';
    _licenseIssueDateController.text = hospitalInfoModel?.licenseIssueDate ?? '';
    _licenseExpireDateController.text = hospitalInfoModel?.licenseExpiryDate ?? '';
    _operatingHoursController.text = hospitalInfoModel?.operatingHours ?? '';
  }
}

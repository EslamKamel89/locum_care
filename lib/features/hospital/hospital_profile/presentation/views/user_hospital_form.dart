import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/core/widgets/searchable_dropdown_widget.dart';
import 'package:locum_care/features/common_data/cubits/districts_data/districts_data_cubit.dart';
import 'package:locum_care/features/common_data/cubits/state/state_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/district_model.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/user_update/user_update_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/update_password.dart';

class UserHospitalForm extends StatefulWidget {
  const UserHospitalForm({super.key});

  @override
  State<UserHospitalForm> createState() => _UserHospitalFormState();
}

class _UserHospitalFormState extends State<UserHospitalForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  late UserUpdateCubit controller;
  late HospitalUserModel? _hospitalUserModel;
  String _selectedState = '';
  int? _selectedStateId;
  String _selectedDistrict = '';
  int? _selectedDistrictId;
  @override
  void initState() {
    _hospitalUserModel = context.read<UserInfoCubit>().state.hospitalUserModel;
    controller = context.read<UserUpdateCubit>();
    _initializeTextFieldIfUpdating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserUpdateCubit, UserUpdateState>(
      listener: (context, state) {
        if (state.responseType == ResponseEnum.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: "Basic Information",
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    'Name *',
                    _nameController,
                    'Enter Name',
                    validator: (String? value) {
                      return valdiator(input: value, label: 'Name', isRequired: true);
                    },
                  ),
                  CustomTextField(
                    'Email *',
                    _emailController,
                    'Enter Email',
                    validator: (String? value) {
                      return valdiator(
                        input: value,
                        label: 'Email',
                        isRequired: true,
                        isEmail: true,
                      );
                    },
                  ),
                  _customDivider(),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => StateCubit(serviceLocator())..fetchStates(),
                      ),
                      BlocProvider(create: (context) => DistrictsDataCubit(serviceLocator())),
                    ],
                    child: Builder(
                      builder: (context) {
                        final stateController = context.watch<StateCubit>();
                        final districtDataController = context.watch<DistrictsDataCubit>();
                        return Column(
                          children: [
                            SearchableDropdownWidget(
                              label: 'State',
                              hintText: 'Select State',
                              isRequired: true,
                              initalValue: _hospitalUserModel?.state?.name,
                              options:
                                  stateController.state.stateModels
                                      ?.map((stateModel) => stateModel.name ?? '')
                                      .toList() ??
                                  [],
                              handleSelectOption: (String option) {
                                _selectedState = option;
                                int? stateId = getStateId(
                                  _selectedState,
                                  stateController.state.stateModels,
                                );
                                _selectedStateId = stateId;
                                if (stateId == null) return;
                                districtDataController.fetchDistrictsData(stateId);
                              },
                            ),
                            const SizedBox(height: 15),
                            SearchableDropdownWidget(
                              label: 'District (Optional)',
                              hintText: 'Select District',
                              isRequired: false,
                              initalValue: _hospitalUserModel?.district?.name,
                              options:
                                  districtDataController.state.districtsDataModel?.districts
                                      ?.map((districtModel) => districtModel?.name ?? '')
                                      .toList() ??
                                  [],
                              handleSelectOption: (String option) {
                                _selectedDistrict = option;
                                _selectedDistrictId = getDistrictId(
                                  option,
                                  districtDataController.state.districtsDataModel,
                                );
                                // controller.selectDistrict(option);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _customDivider(),
                  PasswordUpdate(
                    passwordController: _passwordController,
                    passwordConfirmController: _passwordConfirmController,
                  ),
                  const SizedBox(height: 15),
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
        UserDoctorParams(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          stateId: _selectedStateId ?? _hospitalUserModel?.state?.id,
          districtId: _selectedDistrictId ?? _hospitalUserModel?.district?.id,
        ),
        'userDoctorParams',
      );
      controller.updateUserDoctor(params: params);
    }
  }

  Widget _customDivider() {
    return const Column(children: [SizedBox(height: 15), Divider(), SizedBox(height: 15)]);
  }

  int? getStateId(String? stateName, List<StateModel>? states) {
    if (stateName == null || states == null) return null;
    StateModel? selectedStateModel =
        states.where((stateModel) => stateModel.name == stateName).first;
    return selectedStateModel.id;
  }

  int? getDistrictId(String slectedDistricName, DistrictsDataModel? districtsDataModel) {
    DistrictModel? selectedDistrictModel =
        districtsDataModel?.districts
            ?.where((districtModel) => districtModel?.name == slectedDistricName)
            .first;

    return selectedDistrictModel?.id;
  }

  void _initializeTextFieldIfUpdating() {
    if (_hospitalUserModel == null) return;
    _nameController.text = _hospitalUserModel?.name ?? '';
    _emailController.text = _hospitalUserModel?.email ?? '';
    _selectedState = _hospitalUserModel?.state?.name ?? '';
    _selectedDistrict = _hospitalUserModel?.district?.name ?? '';
  }
}

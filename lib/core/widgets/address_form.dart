// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/searchable_dropdown_widget.dart';
import 'package:locum_care/features/common_data/cubits/districts_data/districts_data_cubit.dart';
import 'package:locum_care/features/common_data/cubits/state/state_cubit.dart';
import 'package:locum_care/features/common_data/data/models/district_model.dart';
import 'package:locum_care/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_care/features/common_data/data/models/state_model.dart';
import 'package:locum_care/utils/styles/styles.dart';

class AddressFormWithDropdowns extends StatefulWidget {
  const AddressFormWithDropdowns({super.key, required this.handleSaveAddress});
  final void Function(String) handleSaveAddress;

  @override
  State<AddressFormWithDropdowns> createState() => _AddressFormWithDropdownsState();
}

class _AddressFormWithDropdownsState extends State<AddressFormWithDropdowns> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for non-dropdown fields
  final TextEditingController streetController = TextEditingController();
  final TextEditingController aptNumberController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  ValueNotifier<AmericanAddress> address = ValueNotifier(
    AmericanAddress(
      streetAddress: '[Street Address]',
      unitNumber: '[Unit/Suite/Apt Number]',
      district: '[City]',
      state: '[State]',
      zipCode: '[ZIP Code]',
    ),
  );
  // Dropdown selections
  String? _selectedState;
  int? _selectedStateId;
  String? _selectedDistrict;
  int? _selectedDistrictId;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: address,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            // padding: const EdgeInsets.only(bottom: 0),
            child: Form(
              key: _formKey,
              child: ListView(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  // Street Address Field
                  TextFormField(
                    controller: streetController,
                    decoration: const InputDecoration(
                      labelText: 'Street Address',
                      hintText: '123 Main Street',
                    ),
                    onChanged: (value) {
                      address.value = address.value.copyWith(streetAddress: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a street address.';
                      }
                      // if (!RegExp(r'^\d+\s[A-Za-z\s]+$').hasMatch(value)) {
                      //   return 'Enter a valid street address.';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: aptNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Unit/Suite/Apt Number',
                      hintText: 'Apt 4B',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Unit/Suite/Apt Number.';
                      }
                      // if (!RegExp(r'^\d+\s[A-Za-z\s]+$').hasMatch(value)) {
                      //   return 'Enter a valid street address.';
                      // }
                      return null;
                    },
                    onChanged: (value) {
                      address.value = address.value.copyWith(unitNumber: value);
                    },
                  ),
                  const SizedBox(height: 16),

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
                              // initalValue: _doctorUserModel?.state?.name,
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
                                address.value = address.value.copyWith(state: option);
                              },
                            ),
                            const SizedBox(height: 15),
                            if (_selectedState != null && _selectedState != '')
                              Column(
                                children: [
                                  SearchableDropdownWidget(
                                    label: 'City',
                                    hintText: 'Select City',
                                    isRequired: true,
                                    // initalValue: _doctorUserModel?.district?.name,
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
                                      address.value = address.value.copyWith(district: option);
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ),

                  // ZIP Code Field
                  TextFormField(
                    controller: zipCodeController,
                    decoration: const InputDecoration(labelText: 'ZIP Code', hintText: '90015'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a ZIP code.';
                      }
                      // if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(value)) {
                      //   return 'Enter a valid ZIP code.';
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      address.value = address.value.copyWith(zipCode: value);
                    },
                  ),
                  const SizedBox(height: 10),
                  txt(
                    "${address.value.streetAddress} ${address.value.unitNumber}\n${address.value.district}, ${address.value.state} ${address.value.zipCode}",
                    e: St.reg14,
                  ),

                  const SizedBox(height: 32),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.handleSaveAddress(
                          "${address.value.streetAddress} ${address.value.unitNumber}\n${address.value.district}, ${address.value.state} ${address.value.zipCode}",
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
}

class AmericanAddress {
  String? streetAddress;
  String? unitNumber;
  String? state;
  String? district;
  String? zipCode;
  AmericanAddress({this.streetAddress, this.unitNumber, this.state, this.district, this.zipCode});

  AmericanAddress copyWith({
    String? streetAddress,
    String? unitNumber,
    String? state,
    String? district,
    String? zipCode,
  }) {
    return AmericanAddress(
      streetAddress: streetAddress ?? this.streetAddress,
      unitNumber: unitNumber ?? this.unitNumber,
      state: state ?? this.state,
      district: district ?? this.district,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  String toString() {
    return 'AmericanAddress(streetAddress: $streetAddress, unitNumber: $unitNumber, state: $state, district: $district, zipCode: $zipCode)';
  }
}

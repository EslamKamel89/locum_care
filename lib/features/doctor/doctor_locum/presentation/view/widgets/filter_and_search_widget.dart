import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/filter_option_enum.dart';
import 'package:locum_care/core/enums/sort_options_enum.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/searchable_dropdown_widget.dart';
import 'package:locum_care/features/common_data/cubits/job_info/job_info_cubit.dart';
import 'package:locum_care/features/common_data/cubits/language/language_cubit.dart';
import 'package:locum_care/features/common_data/cubits/speciality/speciality_cubit.dart';
import 'package:locum_care/features/common_data/cubits/state/state_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/show_all_add/show_all_adds_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final List<SortOptionsEnum> sortOptions = SortOptionsEnum.values;
  final List<FilterOptionsEnum> filterOptions = FilterOptionsEnum.values;

  SortOptionsEnum selectedSort = SortOptionsEnum.published;
  FilterOptionsEnum? selectedFilter;
  final Map<FilterOptionsEnum, String> activeFilters = {};
  final TextEditingController filterValueController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isVisible
                      ? Text(
                        'Find Your Dream Job',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.secondaryHeaderColor,
                        ),
                      )
                      : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isVisible = true;
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Search For Your Perfect Job',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                  if (isVisible) const Spacer(),
                  if (isVisible)
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: isVisible,
          child: Material(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sort Dropdown
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<SortOptionsEnum>(
                        decoration: InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        value: selectedSort,
                        items:
                            sortOptions.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option.toShortString()),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Filter Value Input
                MultiBlocProvider(
                  providers: [
                    BlocProvider<SpecialtyCubit>(
                      create: (context) => SpecialtyCubit(serviceLocator())..fetchSpecialties(),
                    ),
                    BlocProvider<JobInfoCubit>(
                      create: (context) => JobInfoCubit(serviceLocator())..fetchJobInfos(),
                    ),
                    BlocProvider<StateCubit>(
                      create: (context) => StateCubit(serviceLocator())..fetchStates(),
                    ),
                    BlocProvider<LanguageCubit>(
                      create: (context) => LanguageCubit(serviceLocator())..fetchLanugages(),
                    ),
                    // BlocProvider<SkillCubit>(
                    //     create: (context) =>
                    //         SkillCubit(serviceLocator())..fetchSkills()),
                  ],
                  child: Builder(
                    builder: (context) {
                      final specialtyController = context.watch<SpecialtyCubit>();
                      final jobInfoController = context.watch<JobInfoCubit>();
                      final stateController = context.watch<StateCubit>();
                      final languageController = context.watch<LanguageCubit>();
                      // final skillController = context.watch<SkillCubit>();
                      List<String> options = [];
                      switch (selectedFilter) {
                        case null:
                          break;
                        case FilterOptionsEnum.specialty:
                          options =
                              specialtyController.state.specialtyModels
                                  ?.map((model) => model.name ?? '')
                                  .toList() ??
                              [];
                        case FilterOptionsEnum.jobTitle:
                          options =
                              jobInfoController.state.jobInfoModels
                                  ?.map((model) => model.name ?? '')
                                  .toList() ??
                              [];
                        case FilterOptionsEnum.jobType:
                          break;
                        case FilterOptionsEnum.state:
                          options =
                              stateController.state.stateModels
                                  ?.map((model) => model.name ?? '')
                                  .toList() ??
                              [];
                        case FilterOptionsEnum.languages:
                          options =
                              languageController.state.languageModels
                                  ?.map((model) => model.name ?? '')
                                  .toList() ??
                              [];
                        // case FilterOptionsEnum.skills:
                        //   options = skillController.state.skillModels
                        //           ?.map((model) => model.name ?? '')
                        //           .toList() ??
                        //       [];
                        case FilterOptionsEnum.address:
                          break;
                        case FilterOptionsEnum.distance:
                          options = ["30 Mile", "50 Mile", "100 Mile", "250 Mile", "500 Mile"];
                          break;
                      }
                      if (selectedFilter != null && selectedFilter == FilterOptionsEnum.specialty) {
                        options =
                            specialtyController.state.specialtyModels
                                ?.map((model) => model.name ?? '')
                                .toList() ??
                            [];
                      }
                      return Column(
                        children: [
                          // Filter Dropdown
                          DropdownButtonFormField<FilterOptionsEnum>(
                            decoration: InputDecoration(
                              labelText: 'Filter By',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            value: selectedFilter,
                            items:
                                filterOptions.map((option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Text(option.toShortString()),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value;
                                filterValueController.clear();
                              });
                            },
                          ),
                          if (selectedFilter != null)
                            selectedFilter == FilterOptionsEnum.jobType ||
                                    selectedFilter == FilterOptionsEnum.address
                                ? CustomTextField(
                                  'Enter ${selectedFilter?.toShortString()}',
                                  filterValueController,
                                  selectedFilter?.toShortString() ?? '',
                                )
                                : Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SearchableDropdownWidget(
                                    options: options,
                                    handleSelectOption: (suggestion) {
                                      filterValueController.text = suggestion;
                                    },
                                    label: 'Enter ${selectedFilter?.toShortString()}',
                                    hintText: selectedFilter?.toShortString() ?? '',
                                    isRequired: false,
                                  ),
                                ),
                          // CustomTextFormFieldWithSuggestions(
                          //     label: 'Enter ${selectedFilter?.toShortString()}',
                          //     suggestions: pr(options, 'options'),
                          //     onSelected: (suggestion) {
                          //       filterValueController.text = suggestion;
                          //     },
                          //     controller: filterValueController,
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Please enter a value for $selectedFilter';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          if (selectedFilter != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (filterValueController.text.isNotEmpty) {
                                    setState(() {
                                      activeFilters.addAll({
                                        selectedFilter!: filterValueController.text,
                                      });
                                      selectedFilter = null;
                                      filterValueController.clear();
                                    });
                                  }
                                },
                                child: const Text('Add Filter'),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

                if (selectedFilter != null) const SizedBox(height: 16),

                // Active Filters Display
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      activeFilters.entries.map((filter) {
                        return Chip(
                          label: Text('${filter.key.toShortString()}: ${filter.value}'),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              activeFilters.remove(filter.key);
                            });
                            _sendRequest();
                          },
                        );
                      }).toList(),
                ),
                const SizedBox(height: 10),
                if (activeFilters.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _sendRequest();
                    },
                    child: const Text('Search'),
                  ),
                if (activeFilters.isNotEmpty) const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _sendRequest() {
    final params = pr(
      ShowAllJobAddsParams(
        jobInfo:
            activeFilters.containsKey(FilterOptionsEnum.jobTitle)
                ? activeFilters[FilterOptionsEnum.jobTitle]
                : null,
        specialty:
            activeFilters.containsKey(FilterOptionsEnum.specialty)
                ? activeFilters[FilterOptionsEnum.specialty]
                : null,
        createdAt: selectedSort == SortOptionsEnum.published ? 1 : 0,
        salaryMax: selectedSort == SortOptionsEnum.salary ? 1 : 0,
        langs:
            activeFilters.containsKey(FilterOptionsEnum.languages)
                ? activeFilters[FilterOptionsEnum.languages]
                : null,
        // skills: activeFilters.containsKey(FilterOptionsEnum.skills)
        //     ? activeFilters[FilterOptionsEnum.skills]
        //     : null,
        jobType:
            activeFilters.containsKey(FilterOptionsEnum.jobType)
                ? activeFilters[FilterOptionsEnum.jobType]
                : null,
        state:
            activeFilters.containsKey(FilterOptionsEnum.state)
                ? activeFilters[FilterOptionsEnum.state]
                : null,
        location:
            activeFilters.containsKey(FilterOptionsEnum.address)
                ? activeFilters[FilterOptionsEnum.address]
                : null,
      ),
      'ShowAllJobAddsParams',
    );
    context.read<ShowAllAddsCubit>().resetState();
    context.read<ShowAllAddsCubit>().showAllJobAdds(params);
  }
}

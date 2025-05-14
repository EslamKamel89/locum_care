import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/features/common_data/cubits/skill/skill_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class MuiltipleValueSkillSelector extends StatefulWidget {
  const MuiltipleValueSkillSelector({super.key, required this.onSkillSelect});
  final Function(String) onSkillSelect;
  @override
  State<MuiltipleValueSkillSelector> createState() => _MuiltipleValueSkillSelectorState();
}

class _MuiltipleValueSkillSelectorState extends State<MuiltipleValueSkillSelector> {
  final TextEditingController textEditingController = TextEditingController();
  late DoctorUserModel? doctorUserModel;
  late DoctorModel? doctorModel;
  // String _selected
  late List<String> selectedSkills;

  @override
  void initState() {
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorModel = doctorUserModel?.doctor;
    selectedSkills = (doctorModel?.skills ?? []).map((skill) => skill.name ?? '').toList();
    widget.onSkillSelect(concatenateSkills(selectedSkills));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocProvider(
          create: (context) => SkillCubit(serviceLocator())..fetchSkills(),
          child: BlocBuilder<SkillCubit, SkillState>(
            builder: (context, state) {
              return CustomTextFormFieldWithSuggestions(
                label: 'Skills',
                suggestions: state.skillModels?.map((skill) => skill.name ?? '').toList() ?? [],
                onSelected: (String value) {
                  setState(() {
                    textEditingController.text = value;
                    if (!selectedSkills.contains(value.toLowerCase().trim())) {
                      selectedSkills.add(value.toLowerCase().trim());
                    }
                  });
                },
                controller: textEditingController,
                onSave: () {
                  setState(() {
                    if (!selectedSkills.contains(textEditingController.text.toLowerCase().trim())) {
                      selectedSkills.add(textEditingController.text.toLowerCase().trim());
                    }
                    widget.onSkillSelect(concatenateSkills(selectedSkills));
                    textEditingController.text = '';
                  });
                },
              );
            },
          ),
        ),
        BadgeWrap(
          items: selectedSkills,
          onDelete: (String skillName) {
            setState(() {
              selectedSkills.remove(skillName.toLowerCase().trim());
            });
            widget.onSkillSelect(concatenateSkills(selectedSkills));
          },
        ),
        if (selectedSkills.isNotEmpty) const SizedBox(height: 10),
      ],
    );
  }

  String concatenateSkills(List<String> skills) {
    String result = '';
    for (var skill in skills) {
      result = '$result,$skill';
    }
    result = result.replaceFirst(',', '').trim().toLowerCase();
    return result;
  }
}

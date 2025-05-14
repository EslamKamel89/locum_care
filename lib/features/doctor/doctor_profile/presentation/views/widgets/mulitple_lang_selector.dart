import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/features/common_data/cubits/language/language_cubit.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class MuiltipleValueLangsSelector extends StatefulWidget {
  const MuiltipleValueLangsSelector({super.key, required this.onLangSelect});
  final Function(String) onLangSelect;
  @override
  State<MuiltipleValueLangsSelector> createState() => _MuiltipleValueLangsSelectorState();
}

class _MuiltipleValueLangsSelectorState extends State<MuiltipleValueLangsSelector> {
  final TextEditingController textEditingController = TextEditingController();
  late DoctorUserModel? doctorUserModel;
  late DoctorModel? doctorModel;
  // String _selected
  late List<String> selectedLangs;

  @override
  void initState() {
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorModel = doctorUserModel?.doctor;
    selectedLangs = (doctorModel?.langs ?? []).map((lang) => lang.name ?? '').toList();
    widget.onLangSelect(concatenateLangs(selectedLangs));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocProvider(
          create: (context) => LanguageCubit(serviceLocator())..fetchLanugages(),
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return CustomTextFormFieldWithSuggestions(
                label: 'Languages',
                suggestions: state.languageModels?.map((lang) => lang.name ?? '').toList() ?? [],
                onSelected: (String value) {
                  setState(() {
                    textEditingController.text = value;
                    if (!selectedLangs.contains(value.toLowerCase().trim())) {
                      selectedLangs.add(value.toLowerCase().trim());
                    }
                  });
                },
                controller: textEditingController,
                onSave: () {
                  setState(() {
                    if (!selectedLangs.contains(textEditingController.text.toLowerCase().trim())) {
                      selectedLangs.add(textEditingController.text.toLowerCase().trim());
                    }
                    widget.onLangSelect(concatenateLangs(selectedLangs));
                    textEditingController.text = '';
                  });
                },
              );
            },
          ),
        ),
        BadgeWrap(
          items: selectedLangs,
          onDelete: (String langName) {
            setState(() {
              selectedLangs.remove(langName.toLowerCase().trim());
            });
            widget.onLangSelect(concatenateLangs(selectedLangs));
          },
        ),
        if (selectedLangs.isNotEmpty) const SizedBox(height: 10),
      ],
    );
  }

  String concatenateLangs(List<String> langs) {
    String result = '';
    for (var lang in langs) {
      result = '$result,$lang';
    }
    result = result.replaceFirst(',', '').trim().toLowerCase();
    return result;
  }
}

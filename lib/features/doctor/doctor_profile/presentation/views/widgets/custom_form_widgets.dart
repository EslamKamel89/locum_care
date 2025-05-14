import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:locum_care/core/heleprs/format_date.dart';

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    super.key,
    required this.onDateSubmit,
    required this.label,
    required this.initialDate,
    required this.textEditingController,
    this.validator,
  });
  final String label;
  final DateTime? initialDate;
  final Function(DateTime date) onDateSubmit;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  // final dateEditingController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText:
                  widget.initialDate != null
                      ? '${widget.initialDate?.year}-${widget.initialDate?.month.toString().padLeft(2, '0')}-${widget.initialDate?.day.toString().padLeft(2, '0')}'
                      : 'Select a date',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            // validator: (_) => widget.selectedDate == null ? '${widget.label} is required' : null,
            validator: widget.validator,
          ),
        ),
      ),
    );
  }

  // Method to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.onDateSubmit(pickedDate);
        // widget.textEditingController.text =
        //     '${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate?.day.toString().padLeft(2, '0')}';
        widget.textEditingController.text = formatDateToAmerican(selectedDate) ?? '';
      });
    }
  }
}

class CustomBiographyForm extends StatelessWidget {
  const CustomBiographyForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 20,
        minLines: 2,
        decoration: InputDecoration(
          labelText: 'Biography',
          hintText: 'Write a brief biography',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label,
    this.controller,
    this.hint, {
    super.key,
    this.inputType = TextInputType.text,
    this.validator,
    this.showMulitLine = false,
    this.readOnly = false,
    this.onTap,
  });
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final bool showMulitLine;
  final bool readOnly;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: inputType,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: validator,
        maxLines: showMulitLine ? 20 : null,
        minLines: showMulitLine ? 2 : null,
      ),
    );
  }
}

class CustomTextFormFieldWithSuggestions extends StatefulWidget {
  const CustomTextFormFieldWithSuggestions({
    super.key,
    required this.label,
    required this.suggestions,
    required this.onSelected,
    required this.controller,
    this.validator,
    this.onSave,
  });
  final List<String> suggestions;
  final String label;
  final Function(String) onSelected;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onSave;
  @override
  State<CustomTextFormFieldWithSuggestions> createState() =>
      _CustomTextFormFieldWithSuggestionsState();
}

class _CustomTextFormFieldWithSuggestionsState extends State<CustomTextFormFieldWithSuggestions> {
  String selectedValue = '';
  @override
  void initState() {
    selectedValue = widget.controller.text;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.controller.text = selectedValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TypeAheadField<String>(
        controller: widget.controller,
        // suggestionsController: SuggestionsController(),
        suggestionsCallback: (search) {
          final result =
              widget.suggestions
                  .where(
                    (String suggestion) =>
                        suggestion.toLowerCase().trim().contains(search.trim().toLowerCase()),
                  )
                  .toList();
          return result;
        },
        builder: (context, controller, focusNode) {
          // controller.text = selectedValue;
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            validator: widget.validator,
            // autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.label,
              suffix:
              // widget.onSave == null
              //     ? null
              //     :
              InkWell(
                onTap: () {
                  if (widget.onSave != null) widget.onSave!();
                  // widget.controller.text = '';
                  focusNode.unfocus();
                },
                child: const Icon(Icons.save),
              ),
            ),
            // onChanged: ,
          );
        },
        itemBuilder: (context, option) {
          return ListTile(
            title: Text(option),
            // subtitle: Text(city.country),
          );
        },
        onSelected: (String option) {
          widget.controller.text = option;
          // widget.onSelected(option);
          setState(() {
            selectedValue = option;
          });
        },
      ),
    );
  }
}

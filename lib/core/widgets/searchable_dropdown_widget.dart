import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/widgets/auth_text_form_field.dart';
import 'package:locum_care/utils/styles/styles.dart';

class SearchableDropdownWidget extends StatefulWidget {
  const SearchableDropdownWidget({
    super.key,
    required this.options,
    required this.handleSelectOption,
    required this.label,
    required this.hintText,
    required this.isRequired,
    this.initalValue,
  });
  final List<String> options;
  final Function handleSelectOption;
  final String label;
  final String hintText;
  final bool isRequired;
  final String? initalValue;
  @override
  State<SearchableDropdownWidget> createState() => _SearchableDropdownWidgetState();
}

class _SearchableDropdownWidgetState extends State<SearchableDropdownWidget> {
  String? selectedOption;
  void _showSearchDialog() async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        return SearchDialog(
          options: widget.options,
          initialValue: selectedOption,
          hintText: widget.hintText,
          label: widget.label,
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedOption = result;
      });
      widget.handleSelectOption(result);
    }
  }

  @override
  void initState() {
    selectedOption = widget.initalValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onTap: _showSearchDialog,
      controller: TextEditingController(text: selectedOption),
      validator: (value) {
        if (!widget.isRequired) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return "Please select an option";
        }
        return null;
      },
    );
  }
}

class SearchDialog extends StatefulWidget {
  const SearchDialog({
    super.key,
    required this.options,
    this.initialValue,
    required this.label,
    required this.hintText,
  });
  final List<String> options;
  final String? initialValue;
  final String label;
  final String hintText;
  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late List<String> filteredOptions;
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      filteredOptions =
          widget.options
              .where((option) => option.trim().toLowerCase().contains(query.trim().toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: AlertDialog(
        title: txt('Search And Select ${widget.label}', c: Colors.white),
        content: SizedBox(
          height: 500.h,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextFormField(
                  labelText: 'Search',
                  controller: searchController,
                  prefixIcon: Icons.search,
                  onChanged: _filterOptions,
                ),
                const SizedBox(height: 10),
                ...List.generate(filteredOptions.length, (index) {
                  return ListTile(
                    title: txt(filteredOptions[index], c: Colors.white),
                    onTap: () {
                      Navigator.of(context).pop(filteredOptions[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

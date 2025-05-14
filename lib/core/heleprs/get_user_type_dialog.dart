import 'package:flutter/material.dart';
import 'package:locum_care/core/enums/user_type_enum.dart';
import 'package:locum_care/core/widgets/dropdown_widget.dart';

Future<UserTypeEnum?> getUserTypeDialog(BuildContext context) async {
  UserTypeEnum? userType = await showDialog<UserTypeEnum>(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you Healthcare Provider or Professional ?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropDownWidget(
                        options:
                            UserTypeEnum.values.map((userType) => userType.toFullString()).toList(),
                        label: 'Provider or Professional',
                        onSelect: (String? value) {
                          if (value == null) return;
                          Navigator.of(context).pop(_selectUserType(value));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  return userType;
}

UserTypeEnum? _selectUserType(String userTypeStr) {
  UserTypeEnum? selectedUserType =
      UserTypeEnum.values.where((userType) => userType.toFullString() == userTypeStr).first;
  return selectedUserType;
}

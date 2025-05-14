import 'package:flutter/material.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/utils/styles/styles.dart';

Future<bool?> showAreYouSureDialog() async {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) return null;
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (contex) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        title: txt('Warning', e: St.bold14, c: Colors.red),
        content: txt('Do You Want To Proceed?!', e: St.semi12, c: Colors.black),
        actions: [
          TextButton(
            child: txt('Yes', e: St.reg12, c: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: txt('No', e: St.reg12, c: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  return result;
}

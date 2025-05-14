// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/themes/theme_cubit.dart';

class ProfileIncompleteWidget extends StatelessWidget {
  final String title;
  final String message;
  final String buttonContent;
  final void Function()? onTap;
  final bool isVisible;
  const ProfileIncompleteWidget({
    super.key,
    this.title = 'Profile Incomplete',
    this.message =
        'You haven\'t completed your profile yet. Please update your profile to enjoy all features.',
    this.buttonContent = 'Update Profile',
    this.isVisible = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return isVisible
        ? Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            // color: themeCubit.isDarkMode() ? Colors.black38 : Colors.white,
            // color: themeCubit.isDarkMode() ? Colors.black38 : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 50.0),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  // color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: onTap,
                child: Text(
                  buttonContent,
                  style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                ),
              ),
            ],
          ),
        )
        : const SizedBox();
  }
}

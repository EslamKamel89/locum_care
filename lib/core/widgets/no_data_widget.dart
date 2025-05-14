import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 400.h,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10.w),
            color: context.secondaryHeaderColor,
          ),
          child: const Text(
            "We're currently out of data.\nHow about exploring other\nsections or trying a\ndifferent search?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ).animate(autoPlay: true).moveX(duration: const Duration(seconds: 1), begin: -400, end: 0),
    );
  }
}

class NoReviewsWidget extends StatelessWidget {
  const NoReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10.w),
            color: context.primaryColor,
          ),
          child: const Text(
            "No reviews found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ).animate(autoPlay: true).moveX(duration: const Duration(seconds: 1), begin: -400, end: 0),
    );
  }
}

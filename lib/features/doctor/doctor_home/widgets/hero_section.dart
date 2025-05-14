import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_care/core/widgets/circular_image_asset.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.doctorUserModel});

  final DoctorUserModel? doctorUserModel;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            // onTap: () {
            //   doctorBottomNavigationBar.navigateTo(2);
            // },
            // child: CircularCachedImage(
            //   imageUrl: widget.doctorUserModel?.doctor?.photo ?? '',
            //   imageAsset: widget.doctorUserModel?.doctor?.gender == 'female'
            //       ? AssetsData.femalePlacholder
            //       : AssetsData.malePlacholder,
            //   height: 100.h,
            //   width: 100.h,
            // ).animate().scale(),
            child:
                CircularLogo(
                  image: AssetsData.logo,
                  height: 100.h,
                  boxFit: BoxFit.fitWidth,
                  horizontalPadding: 20,
                ).animate().scale(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(MdiIcons.stethoscope, size: 30.w),
                  const SizedBox(width: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.secondaryHeaderColor,
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 1.seconds),
                ],
              ),
              const Text(
                'Discover Your Next Locum Opportunity!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  doctorBottomNavigationBar.navigateTo(1);
                },
                icon: const Icon(Icons.search),
                label: const Text('Start Searching', style: TextStyle(fontSize: 14)),
              ).animate().moveX(),
            ],
          ),
        ),
      ],
    );
  }
}

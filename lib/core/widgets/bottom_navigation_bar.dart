import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final doctorBottomNavigationBar = DefaultBottomNavigationBar(
  handleNavigation: (int index) {
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    switch (index) {
      case 0:
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutesNames.doctorHomeScreen, (_) => false);
        break;
      case 1:
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutesNames.doctorLocumScreen, (_) => false);
        break;
      case 2:
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutesNames.doctorProfileScreen, (_) => false);
        break;
    }
  },
);

final hospitalBottomNavigationBar = DefaultBottomNavigationBar(
  handleNavigation: (int index) {
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    switch (index) {
      case 0:
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutesNames.hospitalHomeScreen, (_) => false);
        break;
      case 2:
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutesNames.hospitalProfileScreen, (_) => false);
        break;
    }
  },
);

class DefaultBottomNavigationBar extends StatelessWidget {
  DefaultBottomNavigationBar({super.key, required this.handleNavigation});
  ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
  final Function(int) handleNavigation;
  void navigateTo(int index) {
    currentIndexNotifier.value = index;
    handleNavigation(index);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndexNotifier,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -2), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndexNotifier.value,
            onTap: (index) {
              currentIndexNotifier.value = index;
              handleNavigation(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: value == 0 ? 30.w : 20.w),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.stethoscope, size: value == 1 ? 30.w : 20.w),
                label: 'Locum Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: value == 2 ? 30.w : 20.w),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

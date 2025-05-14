import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/themes/theme_cubit.dart';
import 'package:locum_care/core/themes/toogle_theme_switch.dart';
import 'package:locum_care/core/widgets/circular_image_asset.dart';
import 'package:locum_care/core/widgets/show_are_you_sure_dialog.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/doctor/support/presentation/cubits/unseen_support_message_count/unseen_support_message_count_cubit.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:locum_care/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DefaultDoctorDrawer extends StatelessWidget {
  const DefaultDoctorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UnseenSupportMessageCountCubit>().getUnseenCount();
    final userInfoCubit = context.read<UserInfoCubit>();
    final user = userInfoCubit.state.doctorUserModel;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.primaryColor.withOpacity(0.2), context.primaryColor.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  CircularCachedImage(
                    imageUrl: user?.doctor?.photo ?? '',
                    imageAsset:
                        user?.doctor?.gender == 'female'
                            ? AssetsData.femalePlacholder
                            : AssetsData.malePlacholder,
                    height: 100.h,
                    width: 100.h,
                  ),
                  const SizedBox(height: 12),
                  txt(user?.name ?? '', e: St.bold16),
                  const SizedBox(height: 4),
                  txt(user?.email ?? '', e: St.reg12),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Divider(color: Colors.white70),
            _createDrawerItem(
              context,
              icon: Icons.home,
              text: 'My Applications',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.doctorAllJobApplicationView);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.comment,
              text: 'My Profile Reviews',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.doctorProfileReviewsView);
              },
            ),
            // _createDrawerItem(
            //   context,
            //   icon: Icons.message,
            //   text: 'Inbox',
            //   onTap: () {
            //     Navigator.of(context).pushNamed(AppRoutesNames.messagesView);
            //   },
            // ),

            // BlocBuilder<UnseenSupportMessageCountCubit, UnseenSupportMessageCountState>(
            //   builder: (context, state) {
            //     return ListTile(
            //       title: const Text('Support'),
            //       leading: Icon(MdiIcons.faceAgent, color: context.primaryColor),
            //       trailing: state.notSeenCountModel?.notSeenCount == null || state.notSeenCountModel?.notSeenCount == 0
            //           ? null
            //           : Container(
            //               decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(100)),
            //               padding: const EdgeInsets.all(5),
            //               child: Text(
            //                 state.notSeenCountModel?.notSeenCount?.toString() ?? '0',
            //                 style: const TextStyle(color: Colors.white, fontSize: 18),
            //               ),
            //             ),
            //       onTap: () {
            //         Navigator.of(context).pushNamed(AppRoutesNames.supportView);
            //       },
            //     );
            //   },
            // ),
            _createDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutesNames.userDoctorForm, arguments: {'create': false});
              },
            ),
            // _createDrawerItem(
            //   context,
            //   icon: Icons.contact_mail,
            //   text: 'Contact Us',
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            const Divider(color: Colors.white70),
            ListTile(
              title: const Text('About'),
              leading: Icon(Icons.info, color: context.primaryColor),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.aboutView);
              },
            ),
            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(MdiIcons.themeLightDark, color: context.primaryColor),
                  title: Row(
                    children: [
                      // SizedBox(width: 15.w),
                      // Icon(MdiIcons.themeLightDark),
                      // SizedBox(width: 10.w),
                      Text(state.brightness == Brightness.dark ? 'Light Theme' : 'Dark Theme'),
                      SizedBox(width: 10.w),
                      const ToggleThemeSwitch(),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.logout, color: context.primaryColor),
              title: InkWell(
                onTap: () async {
                  bool result = (await showAreYouSureDialog()) ?? false;
                  if (result) {
                    context.read<UserInfoCubit>().handleSignOut();
                  }
                },
                child: const Text('Sign Out'),
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: context.primaryColor),
      onTap: onTap,
    );
  }
}

class DefaultHospitalDrawer extends StatelessWidget {
  const DefaultHospitalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoCubit = context.read<UserInfoCubit>();
    final user = userInfoCubit.state.hospitalUserModel;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.primaryColor.withOpacity(0.2), context.primaryColor.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  CircularCachedImage(
                    imageUrl: user?.hospital?.photo ?? '',
                    imageAsset: AssetsData.malePlacholder,
                    height: 100.h,
                    width: 100.h,
                  ),
                  const SizedBox(height: 12),
                  txt(user?.name ?? '', e: St.bold16),
                  const SizedBox(height: 4),
                  txt(user?.email ?? '', e: St.reg12),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Divider(color: Colors.white70),
            _createDrawerItem(
              context,
              icon: Icons.home,
              text: 'Your Applications',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.contact_mail,
              text: 'Contact Us',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.white70),
            ListTile(
              title: const Text('About'),
              leading: Icon(Icons.info, color: context.primaryColor),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(MdiIcons.themeLightDark, color: context.primaryColor),
                  title: Row(
                    children: [
                      // SizedBox(width: 15.w),
                      // Icon(MdiIcons.themeLightDark),
                      // SizedBox(width: 10.w),
                      Text(state.brightness == Brightness.dark ? 'Light Theme' : 'Dark Theme'),
                      SizedBox(width: 10.w),
                      const ToggleThemeSwitch(),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.logout, color: context.primaryColor),
              title: InkWell(
                onTap: () async {
                  bool result = (await showAreYouSureDialog()) ?? false;
                  if (result) {
                    context.read<UserInfoCubit>().handleSignOut();
                  }
                },
                child: const Text('Sign Out'),
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: context.primaryColor),
      onTap: onTap,
    );
  }
}

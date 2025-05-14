import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/core/widgets/circular_image_asset.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/comments/presentation/views/comment_view.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/hospital_profile/presentation/cubits/view_hospital_profile/view_hospital_profile_cubit.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:locum_care/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ViewHospitalProfile extends StatefulWidget {
  const ViewHospitalProfile({super.key, required this.id});
  final int id;
  @override
  State<ViewHospitalProfile> createState() => _ViewHospitalProfileState();
}

class _ViewHospitalProfileState extends State<ViewHospitalProfile> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Profile',
      drawer: const DefaultDoctorDrawer(),
      child: SingleChildScrollView(
        child: HospitalProfileContent(id: widget.id),
        // child: SizedBox(),
      ),
    );
  }
}

class HospitalProfileContent extends StatefulWidget {
  const HospitalProfileContent({super.key, required this.id});
  final int id;

  @override
  State<HospitalProfileContent> createState() => _HospitalProfileContentState();
}

class _HospitalProfileContentState extends State<HospitalProfileContent> {
  late final ViewHospitalProfileCubit controller;
  HospitalUserModel? user;
  @override
  void initState() {
    controller = context.read<ViewHospitalProfileCubit>()..fetchHospitalProfileInfo(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ViewHospitalProfileCubit>();
    user = controller.state.hospitalUserModel;
    pr(user?.name, 'user name');
    return controller.state.responseType == ResponseEnum.loading
        ? Container(
          height: 700.h,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircularCachedImage(
                    imageUrl: "${EndPoint.imgBaseUrl}${user?.hospital?.photo ?? ''}",
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
            const SizedBox(height: 24),
            _sectionCard(
              children: [
                _buildSectionHeader('Basic Information'),
                _buildInfo('State', user?.state?.name),
                _buildInfo('District', user?.district?.name),
              ],
              visibility: user != null,
            ),
            SizedBox(height: 15.h),
            _sectionCard(
              children: [
                _buildSectionHeader('Main Facility Information'),
                _buildInfo('Facility Name', user?.hospital?.facilityName),
                _buildInfo('Facility Type', user?.hospital?.type),
                _buildInfo('Contact Person', user?.hospital?.contactPerson),
                _buildInfo('Contact Email', user?.hospital?.contactEmail),
                _buildInfo('Contact Phone', user?.hospital?.contactPhone),
                _buildInfo('Address', user?.hospital?.address),
                _buildInfo('Services Offered', user?.hospital?.servicesOffered, isRow: false),
                _buildInfo('Number of beds', user?.hospital?.numberOfBeds?.toString()),
                _buildInfo('Website Url', user?.hospital?.websiteUrl, isRow: false),
                _buildInfo('Year Established', user?.hospital?.yearEstablished?.toString()),
                _buildInfo('Facility Overview', user?.hospital?.overview, isRow: false),
              ],
              visibility: user?.hospital != null,
              showDivider: true,
            ),
            SizedBox(height: 15.h),
            _sectionCard(
              children: [
                _buildSectionHeader('Additional Information'),
                _buildInfo('License Number', user?.hospital?.hospitalInfo?.licenseNumber),
                _buildInfo('License State', user?.hospital?.hospitalInfo?.licenseState),
                _buildInfo('License Issue Date', user?.hospital?.hospitalInfo?.licenseIssueDate),
                _buildInfo('License Expiry Date', user?.hospital?.hospitalInfo?.licenseExpiryDate),
                _buildInfo('Operating Hours', user?.hospital?.hospitalInfo?.operatingHours),
                _buildInfo(
                  'Staffing Levels',
                  user?.hospital?.hospitalInfo?.staffingLevels,
                  isRow: false,
                ),
                _buildInfo(
                  'Feedback Method',
                  user?.hospital?.hospitalInfo?.feedbackMethod,
                  isRow: false,
                ),
                _buildInfo(
                  'General Policy',
                  user?.hospital?.hospitalInfo?.generalPolicy,
                  isRow: false,
                ),
                _buildInfo(
                  'Emergency Policy',
                  user?.hospital?.hospitalInfo?.emergencyPolicy,
                  isRow: false,
                ),
                _buildInfo(
                  'Affiliations',
                  user?.hospital?.hospitalInfo?.affiliations,
                  isRow: false,
                ),
                if (user?.hospital?.hospitalInfo?.servicesOffered?.isNotEmpty == true)
                  Column(
                    children: [
                      SizedBox(height: 15.h),
                      _buildSectionHeader('Services Offered'),
                      BadgeWrap(items: user?.hospital?.hospitalInfo?.servicesOffered ?? []),
                      SizedBox(height: 15.h),
                      _buildSectionHeader('Notification Preferences'),
                      BadgeWrap(items: user?.hospital?.hospitalInfo?.notifcationPreferences ?? []),
                    ],
                  ),
              ],
              visibility: user?.hospital != null,
              showDivider: true,
            ),
            if (user?.hospital?.id != null)
              CommentView(commentableType: 'hospital', commentableId: (user?.hospital?.id)!),
            // Builder(builder: (context) {
            //   List<HospitalDocumentModel> documents = user?.hospital?.hospitalDocuments ?? [];
            //   return _sectionCard(
            //     children: [
            //       _buildSectionHeader('Documents'),
            //       ...documents.map((document) => _buildDocumentRow(document.type ?? '', document.file ?? '')),
            //     ],
            //     visibility: documents.isNotEmpty,
            //   );
            // }),
            // HopitalProfileNotCompleteWidgets(user: user),
            // SizedBox(height: 15.h),
          ],
        );
  }

  Widget _buildSectionHeader(String title, {void Function()? handleEdit}) {
    BuildContext? context = navigatorKey.currentContext;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: navigatorKey.currentContext!.primaryColor,
          ),
        ),
        if (handleEdit != null)
          IconButton(
            onPressed: handleEdit,
            icon: Icon(MdiIcons.circleEditOutline, color: context?.primaryColor),
          ),
      ],
    );
  }

  Widget _buildInfo(String? label, String? value, {bool isRow = true}) {
    if (value == null) return const SizedBox();
    final content = [
      label == null
          ? const SizedBox()
          : Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: navigatorKey.currentContext!.primaryColor.withRed(5),
            ),
          ),
      label == null ? const SizedBox() : SizedBox(width: 15.w, height: 5.w),
      Text(
        value,
        textAlign: isRow ? TextAlign.end : TextAlign.start,
        style: const TextStyle(
          // color: Colors.black54,
        ),
        maxLines: isRow ? 1 : null,
        overflow: isRow ? TextOverflow.clip : null,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child:
          isRow
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: content,
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: content,
              ),
    );
  }

  Widget _sectionCard({
    required List<Widget> children,
    bool visibility = true,
    bool showDivider = true,
  }) {
    return visibility
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            ...children,
            if (showDivider) Divider(color: Colors.grey.withOpacity(0.5)),
          ],
        )
        : const SizedBox();
  }
}

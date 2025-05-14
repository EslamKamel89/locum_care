import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/format_date.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/widgets/badge_wrap.dart';
import 'package:locum_care/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_care/core/widgets/circular_image_asset.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/add_new_document.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/doctor_document_widget.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/widgets/doctor_profile_not_complete_widgets.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:locum_care/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileView extends StatefulWidget {
  const DoctorProfileView({super.key});

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  @override
  void initState() {
    context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Profile',
      bottomNavigationBar: doctorBottomNavigationBar,
      drawer: const DefaultDoctorDrawer(),
      child: const SingleChildScrollView(child: DoctorProfileContent()),
    );
  }
}

class DoctorProfileContent extends StatelessWidget {
  const DoctorProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoCubit = context.watch<UserInfoCubit>();
    final user = userInfoCubit.state.doctorUserModel;

    return userInfoCubit.state.responseType == ResponseEnum.loading
        ? Container(
          height: 700.h,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: User Photo, Name, and Email
            Center(
              child: Column(
                children: [
                  CircularCachedImage(
                    imageUrl: "${EndPoint.imgBaseUrl}${user?.doctor?.photo ?? ''}",
                    imageAsset:
                        user?.doctor?.gender == 'female'
                            ? AssetsData.femalePlacholder
                            : AssetsData.malePlacholder,
                    height: 100.h,
                    width: 100.h,
                  ),
                  const SizedBox(height: 12),
                  txt(user?.name ?? '', e: St.bold16),
                  // const SizedBox(height: 4),
                  // txt(user?.email ?? '', e: St.reg12),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // Section 2: User Information
            _sectionCard(
              children: [
                _buildSectionHeader(
                  'Basic Information',
                  handleEdit: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutesNames.userDoctorForm, arguments: {'create': false});
                  },
                ),
                _buildInfo('Email', user?.email),
                _buildInfo('State', user?.state?.name),
                _buildInfo('City', user?.district?.name),
              ],
              visibility: user != null,
            ),

            SizedBox(height: 15.h),

            // Section 3: Main Professional Information
            _sectionCard(
              children: [
                _buildSectionHeader(
                  'Main Professional Information',
                  handleEdit: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutesNames.doctorForm, arguments: {'create': false});
                  },
                ),
                _buildInfo('Specialty', user?.doctor?.specialty?.name),
                _buildInfo('Job Title', user?.doctor?.jobInfo?.name),
                _buildInfo('Date of Birth', formatStrDateToAmerican(user?.doctor?.dateOfBirth)),
                _buildInfo('Gender', user?.doctor?.gender),
                _buildInfo('Address', user?.doctor?.address),
                _buildInfo('Phone', user?.doctor?.phone),
                _buildInfo(
                  'Willing to Relocate',
                  user?.doctor?.willingToRelocate == null ||
                          user?.doctor?.willingToRelocate == false
                      ? 'No'
                      : 'Yes',
                ),
                //  Languages Spoken
                Builder(
                  builder: (context) {
                    List<LanguageModel> langs = user?.doctor?.langs ?? [];
                    String langsStr = '';
                    for (var lang in langs) {
                      langsStr = '$langsStr , ${lang.name} ';
                    }
                    langsStr = langsStr.replaceFirst(',', '').trim();
                    return _sectionCard(
                      children: [
                        _buildSectionHeader('Languages Spoken'),
                        // _buildInfo(null, langsStr, isRow: false),
                        const SizedBox(height: 5),
                        BadgeWrap(items: langs.map((lang) => lang.name ?? '').toList()),
                      ],
                      visibility: langs.isNotEmpty,
                      showDivider: false,
                    );
                  },
                ),

                //  Doctor Skills
                // Builder(
                //   builder: (context) {
                //     List<SkillModel> skills = user?.doctor?.skills ?? [];
                //     String skillsStr = '';
                //     for (var skill in skills) {
                //       skillsStr = '$skillsStr , ${skill.name} ';
                //     }
                //     skillsStr = skillsStr.replaceFirst(',', '').trim();
                //     return _sectionCard(
                //       children: [
                //         _buildSectionHeader('Skills'),
                //         // _buildInfo(null, skillsStr, isRow: false),
                //         const SizedBox(height: 5),
                //         BadgeWrap(items: skills.map((skill) => skill.name ?? '').toList())
                //       ],
                //       visibility: skills.isNotEmpty,
                //       showDivider: false,
                //     );
                //   },
                // ),
              ],
              visibility: user?.doctor != null,
            ),

            // Section 4: Additional Professional Information
            _sectionCard(
              children: [
                _buildSectionHeader(
                  'Additional Professional Information',
                  handleEdit: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutesNames.doctorInfoForm, arguments: {'create': false});
                  },
                ),
                _buildInfo(
                  'Professional License No.',
                  user?.doctor?.doctorInfo?.professionalLicenseNumber,
                ),
                _buildInfo('License State', user?.doctor?.doctorInfo?.licenseState),
                _buildInfo(
                  'License Issue Date',
                  formatStrDateToAmerican(user?.doctor?.doctorInfo?.licenseIssueDate),
                ),
                _buildInfo(
                  'License Expiry Date',
                  formatStrDateToAmerican(user?.doctor?.doctorInfo?.licenseExpiryDate),
                ),
                _buildInfo('University', user?.doctor?.doctorInfo?.university?.name),
                _buildInfo('Highest Degree', user?.doctor?.doctorInfo?.highestDegree),
                _buildInfo('Residency ', user?.doctor?.doctorInfo?.fieldOfStudy),
                _buildInfo('Graduation Year', user?.doctor?.doctorInfo?.graduationYear.toString()),
                _buildInfo(
                  'Work Experience',
                  user?.doctor?.doctorInfo?.workExperience,
                  isRow: false,
                ),
                _buildInfo('Biography', user?.doctor?.doctorInfo?.biography, isRow: false),
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri.parse("${EndPoint.imgBaseUrl}${user?.doctor?.doctorInfo?.cv ?? ''}"),
                    );
                  },
                  child: Text(
                    'View CV',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: navigatorKey.currentContext!.primaryColor.withRed(5),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
              visibility: user?.doctor?.doctorInfo != null,
            ),

            // Section 7: Doctor Documents
            Builder(
              builder: (context) {
                List<DoctorDocumentModel> documents = user?.doctor?.doctorDocuments ?? [];
                return _sectionCard(
                  children: [
                    _buildSectionHeader('Documents'),
                    ...documents.map(
                      (document) => DoctorDocumentWidget(doctorDocumentModel: document),
                    ),
                    const AddNewDocumentWidget(),
                  ],
                  visibility: documents.isNotEmpty,
                );
              },
            ),
            DoctorProfileNotCompleteWidgets(user: user),
            SizedBox(height: 15.h),
          ],
        );
  }

  Widget _buildSectionHeader(String title, {void Function()? handleEdit}) {
    BuildContext? context = navigatorKey.currentContext;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navigatorKey.currentContext!.primaryColor,
            ),
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
              color: navigatorKey.currentContext!.secondaryHeaderColor,
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

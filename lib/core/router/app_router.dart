import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/router/app_routes_names.dart';
import 'package:locum_care/core/router/middleware.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:locum_care/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:locum_care/features/auth/presentation/views/sign_in/sign_in_screen.dart';
import 'package:locum_care/features/auth/presentation/views/sign_up/signup_screen.dart';
import 'package:locum_care/features/doctor/about/presentation/about_view.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/cubits/doctor_job_application/doctor_job_application_cubit.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/doctor_job_application_details_view.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/presentation/views/doctor_job_application_view.dart';
import 'package:locum_care/features/doctor/doctor_home/doctor_home_view.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/apply_to_job_add/apply_to_job_add_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/show_all_add/show_all_adds_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/show_job_add/show_job_add_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/view/doctor_job_add_details_view.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/view/doctor_locum_view.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/doctor/doctor_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/doctor_info/doctor_info_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/user_update/user_update_cubit.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/doctor_form.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/doctor_info_form.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/doctor_profile_reviews_view.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/doctor_profile_view.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/views/user_doctor_form.dart';
import 'package:locum_care/features/doctor/hospital_profile/presentation/cubits/view_hospital_profile/view_hospital_profile_cubit.dart';
import 'package:locum_care/features/doctor/hospital_profile/presentation/views/view_hospital_profile.dart';
import 'package:locum_care/features/doctor/messages/presentation/views/messages_view.dart';
import 'package:locum_care/features/doctor/support/presentation/views/support_chat_view.dart';
import 'package:locum_care/features/hospital/hospital_home/hospital_home_view.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/cubits/hospital-info/hospital_info_cubit.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/cubits/hospital/hospital_cubit.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/views/hospital_form.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/views/hospital_info_form.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/views/hospital_profile_view.dart';
import 'package:locum_care/features/hospital/hospital_profile/presentation/views/user_hospital_form.dart';
import 'package:locum_care/features/splash_onboarding/presention/views/on_bording_screen.dart';
import 'package:locum_care/features/splash_onboarding/presention/views/splash_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>?;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(builder: (context) => const SplashScreen(), settings: routeSettings);
      case AppRoutesNames.onboardingScreen:
        return CustomPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signinScreen:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SignInCubit(authRepo: serviceLocator()),
                child: const SignInScreen(),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.signupScreen:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) =>
                        SignUpCubit(commonDataRepo: serviceLocator(), authRepo: serviceLocator())
                          ..fetchStates(),
                child: const SignUpScreen(),
              ),
          settings: routeSettings,
        );

      case AppRoutesNames.doctorHomeScreen:
        return CustomPageRoute(
          builder: (context) => const DoctorHomeScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorProfileScreen:
        return CustomPageRoute(
          builder: (context) => const DoctorProfileView(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorInfoForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => DoctorInfoCubit(doctorProfileRepo: serviceLocator()),
                child: DoctorInfoForm(create: args?['create'] ?? true),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => DoctorCubit(serviceLocator()),
                child: DoctorForm(create: args?['create']),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.userDoctorForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => UserUpdateCubit(serviceLocator()),
                child: const UserDoctorForm(),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.hospitalHomeScreen:
        return CustomPageRoute(
          builder: (context) => const HospitalHomeScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.hospitalProfileScreen:
        return CustomPageRoute(
          builder: (context) => const HospitalProfileView(),
          settings: routeSettings,
        );
      case AppRoutesNames.userHospitalForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => UserUpdateCubit(serviceLocator()),
                child: const UserHospitalForm(),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.hospitalForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => HospitalCubit(serviceLocator()),
                child: HospitalForm(create: args?['create']),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.hospitalInfoForm:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => HospitalInfoCubit(serviceLocator()),
                child: HospitalInfoForm(create: args?['create']),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorLocumScreen:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ShowAllAddsCubit(serviceLocator()),
                child: const DoctorLocumView(),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorJobDetailsScreen:
        return CustomPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => ShowJobAddCubit(serviceLocator())),
                  BlocProvider(create: (context) => ApplyToJobAddCubit(serviceLocator())),
                ],
                child: DoctorJobAddDetailsView(id: args?['id']),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorAllJobApplicationView:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => DoctorJobApplicationCubit(serviceLocator()),
                child: const DoctorAllJobApplicationView(),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorJobApplicationDetailsView:
        return CustomPageRoute(
          builder:
              (context) => DoctorJobApplicationDetailsView(jobApplicationModel: args?['model']),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorProfileReviewsView:
        return CustomPageRoute(
          builder: (context) => const DoctorProfileReviewsView(),
          settings: routeSettings,
        );
      case AppRoutesNames.viewHospitalProfile:
        return CustomPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ViewHospitalProfileCubit(serviceLocator()),
                child: ViewHospitalProfile(id: args?['id']),
              ),
          settings: routeSettings,
        );
      case AppRoutesNames.messagesView:
        return CustomPageRoute(builder: (context) => const MessagesView(), settings: routeSettings);
      case AppRoutesNames.supportView:
        return CustomPageRoute(
          builder: (context) => const SupportChatView(),
          settings: routeSettings,
        );
      case AppRoutesNames.aboutView:
        return CustomPageRoute(builder: (context) => const AboutView(), settings: routeSettings);
      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

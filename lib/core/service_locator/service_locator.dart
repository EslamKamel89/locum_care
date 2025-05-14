import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/dio_consumer.dart';
import 'package:locum_care/core/router/app_router.dart';
import 'package:locum_care/core/router/middleware.dart';
import 'package:locum_care/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:locum_care/features/auth/data/repos/auth_repo_imp.dart';
import 'package:locum_care/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_care/features/comments/data/data_source/comment_remote_data_source.dart';
import 'package:locum_care/features/comments/data/repos/comment_repo_imp.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/common_data/data/data_source/common_data_remote_source.dart';
import 'package:locum_care/features/common_data/data/repos/common_data_repo_imp.dart';
import 'package:locum_care/features/common_data/domain/repos/common_data_repo.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/data/remote_datasource/doctor_job_application_remote_datasource.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/data/repos/doctor_job_application_repo_imp.dart';
import 'package:locum_care/features/doctor/doctor-job-applications/domain/repos/doctor_job_application_repo.dart';
import 'package:locum_care/features/doctor/doctor_locum/data/data-source/doctor_locum_remote_datasource.dart';
import 'package:locum_care/features/doctor/doctor_locum/data/repo/doctor_locum_repo_imp.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/data/remote_data_source/doctor_profile_remote_datasource.dart';
import 'package:locum_care/features/doctor/doctor_profile/data/repo/doctor_profile_repo_imp.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/hospital_profile/data/remote_datasource/view_hospital_profile_remote_datasource.dart';
import 'package:locum_care/features/doctor/hospital_profile/data/repo/view_hospital_profile_repo_imp.dart';
import 'package:locum_care/features/doctor/hospital_profile/domain/repo/view_hospital_profile_repo.dart';
import 'package:locum_care/features/doctor/messages/data/remote_datasource/message_remote_datasource.dart';
import 'package:locum_care/features/doctor/messages/data/repos/message_repo_impl.dart';
import 'package:locum_care/features/doctor/messages/domain/repos/message_repo.dart';
import 'package:locum_care/features/doctor/support/data/remote-datasource/support_remotedatasource.dart';
import 'package:locum_care/features/doctor/support/data/repos/support_rep_imp.dart';
import 'package:locum_care/features/doctor/support/domain/repos/support_repo.dart';
import 'package:locum_care/features/hospital/hospital_profile/data/remote_data_source/hospital_profile_remote_datasource.dart';
import 'package:locum_care/features/hospital/hospital_profile/data/repo/hospital_profile_repo_imp.dart';
import 'package:locum_care/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt serviceLocator = GetIt.instance;

Future initServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);
  serviceLocator.registerLazySingleton<ImagePicker>(() => ImagePicker());
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<AppMiddleWare>(
    () => AppMiddleWare(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter(appMiddleWare: serviceLocator()));
  //!
  serviceLocator.registerLazySingleton<CommonDataRemoteSource>(
    () => CommonDataRemoteSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CommonDataRepo>(
    () => CommonDataRepoImp(commonDataRemoteSource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(authRemoteDataSource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<DoctorProfileRemoteDataSource>(
    () => DoctorProfileRemoteDataSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DoctorProfileRepo>(
    () => DoctorProfileRepoImp(doctorProfileRemoteDataSource: serviceLocator()),
  );

  //!
  serviceLocator.registerLazySingleton<HospitalProfileRemoteDatasource>(
    () => HospitalProfileRemoteDatasource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<HospitalProfileRepo>(
    () => HospitalProfileRepoImp(hospitalProfileRemoteDatasource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<DoctorLocumRemoteDataSource>(
    () => DoctorLocumRemoteDataSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DoctorLocumRepo>(
    () => DoctorLocumRepoImp(doctorLocumRemoteDataSource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<DoctorJobApplicationRemoteDataSource>(
    () => DoctorJobApplicationRemoteDataSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DoctorJobApplicationRepo>(
    () => DoctorJobApplicationRepoImp(remoteDataSource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<CommentRemoteDataSource>(
    () => CommentRemoteDataSource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CommentRepo>(
    () => CommentRepoImp(commentRemoteDataSource: serviceLocator()),
  );

  //!
  serviceLocator.registerLazySingleton<ViewHospitalProfileRemoteDatasource>(
    () => ViewHospitalProfileRemoteDatasource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ViewHospitalProfileRepo>(
    () => ViewHospitalProfileRepoImp(remoteDatasource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<MessageRemoteDatasource>(
    () => MessageRemoteDatasource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<MessageRepo>(
    () => MessageRepoImp(remoteSource: serviceLocator()),
  );
  //!
  serviceLocator.registerLazySingleton<SupportRemoteDatasource>(
    () => SupportRemoteDatasource(api: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SupportRepo>(
    () => SupportRepoImp(remoteSource: serviceLocator()),
  );
}

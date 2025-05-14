import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_care/features/doctor/hospital_profile/data/remote_datasource/view_hospital_profile_remote_datasource.dart';
import 'package:locum_care/features/doctor/hospital_profile/domain/repo/view_hospital_profile_repo.dart';

class ViewHospitalProfileRepoImp implements ViewHospitalProfileRepo {
  final ViewHospitalProfileRemoteDatasource remoteDatasource;

  ViewHospitalProfileRepoImp({required this.remoteDatasource});
  @override
  Future<Either<Failure, HospitalUserModel>> fetchHospitalProfileInfo({required int id}) async {
    final t = prt('fetchHospitalProfileInfo  - ViewHospitalProfileRepoImp');
    try {
      HospitalUserModel model = await remoteDatasource.fetchHospitalProfileInfo(id: id);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}

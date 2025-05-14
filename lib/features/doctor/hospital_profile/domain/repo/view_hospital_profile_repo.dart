import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/common_data/data/models/hospital_user_model.dart';

abstract class ViewHospitalProfileRepo {
  Future<Either<Failure, HospitalUserModel>> fetchHospitalProfileInfo({required int id});
}

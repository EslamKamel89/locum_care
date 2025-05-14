import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImp({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    final t = prt('signIn  - AuthRepoImp');
    try {
      UserModel model = await authRemoteDataSource.signIn(email: email, password: password);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignUpParams params) async {
    final t = prt('signIn  - AuthRepoImp');
    try {
      UserModel model = await authRemoteDataSource.signup(params);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, UserModel>> socialAuth(SocialAuthParam params) async {
    final t = prt('socialAuth  - AuthRepoImp');
    try {
      UserModel model = await authRemoteDataSource.socialAuth(params);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}

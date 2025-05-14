// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/auth/domain/repos/auth_repo.dart';

class AuthRemoteDataSource {
  final ApiConsumer api;
  AuthRemoteDataSource({required this.api});
  Future<UserModel> signIn({required String email, required String password}) async {
    final t = prt('signIn - AuthRemoteDataSource');
    final data = await api.post(EndPoint.signin, data: {"email": email, "password": password});
    UserModel userModel = UserModel.fromJson(data['data']);

    return pr(userModel, t);
  }

  Future<UserModel> signup(SignUpParams params) async {
    final t = prt('signup - AuthRemoteDataSource');
    final data = await api.post(EndPoint.signup, data: params.toMap());
    UserModel userModel = UserModel.fromJson(data['data']);

    return pr(userModel, t);
  }

  Future<UserModel> socialAuth(SocialAuthParam params) async {
    final t = prt('socialAuth - AuthRemoteDataSource');
    final data = await api.post(EndPoint.socialAuth, data: params.toMap());
    UserModel userModel = UserModel.fromJson(data['data']);

    return pr(userModel, t);
  }
}

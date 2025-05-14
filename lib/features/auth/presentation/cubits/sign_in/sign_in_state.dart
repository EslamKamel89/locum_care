// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_cubit.dart';

class SignInState {
  String? email;
  String? password;
  String? errorMessage;
  UserEntity? userEntity;
  ResponseEnum? responseType = ResponseEnum.initial;
  SignInState({
    this.email,
    this.password,
    this.errorMessage,
    this.userEntity,
    this.responseType,
  });

  @override
  String toString() {
    return 'SignInState(email: $email, password: $password, errorMessage: $errorMessage, userEntity: $userEntity, responseType: $responseType)';
  }

  SignInState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    UserEntity? userEntity,
    ResponseEnum? responseType,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
      responseType: responseType ?? this.responseType,
    );
  }
}

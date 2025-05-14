// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'social_auth_cubit.dart';

class SocialAuthState {
  String? errorMessage;
  UserEntity? userEntity;
  ResponseEnum? responseType = ResponseEnum.initial;
  SocialAuthState({
    this.errorMessage,
    this.userEntity,
    this.responseType,
  });

  SocialAuthState copyWith({
    String? errorMessage,
    UserEntity? userEntity,
    ResponseEnum? responseType,
  }) {
    return SocialAuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'SocialAuthState(errorMessage: $errorMessage, userEntity: $userEntity, responseType: $responseType)';
}

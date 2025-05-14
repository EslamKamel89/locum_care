// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_all_messages_cubit.dart';

class GetAllMessagesState {
  List<SupportModel>? supportModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  GetAllMessagesState({
    this.supportModels,
    this.errorMessage,
    this.responseType,
  });

  GetAllMessagesState copyWith({
    List<SupportModel>? supportModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return GetAllMessagesState(
      supportModels: supportModels ?? this.supportModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'GetAllMessagesState(supportModels: $supportModels, errorMessage: $errorMessage, responseType: $responseType)';
}

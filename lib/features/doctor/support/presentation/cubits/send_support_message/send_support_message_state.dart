// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'send_support_message_cubit.dart';

class SendSupportMessageState {
  SupportModel? supportModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  SendSupportMessageState({
    this.supportModel,
    this.errorMessage,
    this.responseType,
  });

  SendSupportMessageState copyWith({
    SupportModel? supportModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return SendSupportMessageState(
      supportModel: supportModel ?? this.supportModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'SendSupportMessageState(supportModel: $supportModel, errorMessage: $errorMessage, responseType: $responseType)';
}

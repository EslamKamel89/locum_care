// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'unseen_support_message_count_cubit.dart';

class UnseenSupportMessageCountState {
  NotSeenCountModel? notSeenCountModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  UnseenSupportMessageCountState({
    this.notSeenCountModel,
    this.errorMessage,
    this.responseType,
  });

  UnseenSupportMessageCountState copyWith({
    NotSeenCountModel? notSeenCountModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return UnseenSupportMessageCountState(
      notSeenCountModel: notSeenCountModel ?? this.notSeenCountModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'UnseenSupportMessageCountState(notSeenCountModel: $notSeenCountModel, errorMessage: $errorMessage, responseType: $responseType)';
}

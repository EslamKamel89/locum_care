// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_all_chat_cubit.dart';

class GetAllChatState {
  List<MessageCardModel>? messageCards;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  GetAllChatState({
    this.messageCards,
    this.errorMessage,
    this.responseType,
  });

  GetAllChatState copyWith({
    List<MessageCardModel>? messageCards,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return GetAllChatState(
      messageCards: messageCards ?? this.messageCards,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'GetAllChatState(messageCards: $messageCards, errorMessage: $errorMessage, responseType: $responseType)';
}

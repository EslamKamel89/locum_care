// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'state_cubit.dart';

class StateState {
  List<StateModel>? stateModels;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  StateState({
    this.stateModels,
    this.errorMessage,
    this.responseType,
  });

  StateState copyWith({
    List<StateModel>? stateModels,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return StateState(
      stateModels: stateModels ?? this.stateModels,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'StateState(stateModels: $stateModels, errorMessage: $errorMessage, responseType: $responseType)';
}

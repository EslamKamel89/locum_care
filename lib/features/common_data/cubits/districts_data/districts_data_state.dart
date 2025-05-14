// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'districts_data_cubit.dart';

class DistrictsDataState {
  DistrictsDataModel? districtsDataModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  DistrictsDataState({
    this.districtsDataModel,
    this.errorMessage,
    this.responseType,
  });

  DistrictsDataState copyWith({
    DistrictsDataModel? districtsDataModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return DistrictsDataState(
      districtsDataModel: districtsDataModel ?? this.districtsDataModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'DistrictsDataState(districtsDataModel: $districtsDataModel, errorMessage: $errorMessage, responseType: $responseType)';
}

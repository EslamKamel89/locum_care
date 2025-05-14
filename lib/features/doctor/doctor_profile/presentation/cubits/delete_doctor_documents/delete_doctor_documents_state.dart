// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_doctor_documents_cubit.dart';

class DeleteDoctorDocumentsState {
  ResponseEnum? responseType = ResponseEnum.initial;
  bool? deleteResult;
  String? errorMessage;
  DeleteDoctorDocumentsState({
    this.responseType,
    this.deleteResult,
    this.errorMessage,
  });

  DeleteDoctorDocumentsState copyWith({
    ResponseEnum? responseType,
    bool? deleteResult,
    String? errorMessage,
  }) {
    return DeleteDoctorDocumentsState(
      responseType: responseType ?? this.responseType,
      deleteResult: deleteResult ?? this.deleteResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'DeleteDoctorDocumentsState(responseType: $responseType, deleteResult: $deleteResult, errorMessage: $errorMessage)';
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_doctor_documents_cubit.dart';

class CreateDoctorDocumentsState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  CreateDoctorDocumentParams? doctorDocumentParams;
  DoctorDocumentModel? doctorDocumentModel;
  CreateDoctorDocumentsState({
    this.errorMessage,
    this.responseType,
    this.doctorDocumentParams,
    this.doctorDocumentModel,
  });

  CreateDoctorDocumentsState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    CreateDoctorDocumentParams? doctorDocumentParams,
    DoctorDocumentModel? doctorDocumentModel,
  }) {
    return CreateDoctorDocumentsState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      doctorDocumentParams: doctorDocumentParams ?? this.doctorDocumentParams,
      doctorDocumentModel: doctorDocumentModel ?? this.doctorDocumentModel,
    );
  }

  @override
  String toString() {
    return 'CreateDoctorDocumentsState(errorMessage: $errorMessage, responseType: $responseType, doctorDocumentParams: $doctorDocumentParams, doctorDocumentModel: $doctorDocumentModel)';
  }
}

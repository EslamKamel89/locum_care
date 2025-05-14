import 'package:locum_care/features/common_data/data/models/pagination_model.dart';

class ResponseModel<T> {
  T? data;
  String? status;
  String? message;
  List? errors;
  int? statusCode;
  PaginationModel? pagination;

  ResponseModel({
    this.data,
    this.status,
    this.message,
    this.errors,
    this.statusCode,
    this.pagination,
  });

  @override
  String toString() {
    return 'ResponseModel(data: $data, status: $status, message: $message, errors: $errors, statusCode: $statusCode, meta: $pagination)';
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    status: json['status'] as String?,
    message: json['message'] as String?,
    errors: json['errors'] as List?,
    statusCode: json['statusCode'] as int?,
    pagination:
        json['meta'] == null
            ? null
            : PaginationModel.fromJson(json['meta'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'data': data,
    'status': status,
    'message': message,
    'errors': errors,
    'statusCode': statusCode,
    'meta': pagination?.toJson(),
  };
}

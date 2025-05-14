import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';

class JobApplicationDetailsModel {
  int? id;
  int? jobAddId;
  int? doctorId;
  String? status;
  String? applicationDate;
  String? additionalNotes;
  String? createdAt;
  String? updatedAt;
  JobAddModel? jobAdd;

  JobApplicationDetailsModel({
    this.id,
    this.jobAddId,
    this.doctorId,
    this.status,
    this.applicationDate,
    this.additionalNotes,
    this.createdAt,
    this.updatedAt,
    this.jobAdd,
  });

  @override
  String toString() {
    return 'JobApplicationDetailsModel(id: $id, jobAddId: $jobAddId, doctorId: $doctorId, status: $status, applicationDate: $applicationDate, additionalNotes: $additionalNotes, createdAt: $createdAt, updatedAt: $updatedAt, jobAdd: $jobAdd)';
  }

  factory JobApplicationDetailsModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationDetailsModel(
      id: json['id'] as int?,
      jobAddId: json['job_add_id'] as int?,
      doctorId: json['doctor_id'] as int?,
      status: json['status'] as String?,
      applicationDate: json['application_date'] as String?,
      additionalNotes: json['additional_notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      jobAdd: json['job_add'] == null ? null : JobAddModel.fromJson(json['job_add']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'job_add_id': jobAddId,
    'doctor_id': doctorId,
    'status': status,
    'application_date': applicationDate,
    'additional_notes': additionalNotes,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'job_add': jobAdd,
  };
}

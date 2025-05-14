class JobApplicationModel {
  int? jobAddId;
  String? additionalNotes;
  int? doctorId;
  String? updatedAt;
  String? createdAt;
  int? id;

  JobApplicationModel({
    this.jobAddId,
    this.additionalNotes,
    this.doctorId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  @override
  String toString() {
    return 'JobApplicationModel(jobAddId: $jobAddId, additionalNotes: $additionalNotes, doctorId: $doctorId, updatedAt: $updatedAt, createdAt: $createdAt, id: $id)';
  }

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      jobAddId: json['job_add_id'] as int?,
      additionalNotes: json['additional_notes'] as String?,
      doctorId: json['doctor_id'] as int?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'job_add_id': jobAddId,
        'additional_notes': additionalNotes,
        'doctor_id': doctorId,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
      };
}

class DoctorDocumentModel {
  int? id;
  int? doctorId;
  String? type;
  String? file;

  DoctorDocumentModel({this.id, this.doctorId, this.type, this.file});

  @override
  String toString() {
    return 'DoctorDocumentModel(id: $id, doctorId: $doctorId, type: $type, file: $file)';
  }

  factory DoctorDocumentModel.fromJson(Map<String, dynamic> json) {
    return DoctorDocumentModel(
      id: json['id'] as int?,
      doctorId: json['doctor_id'] as int?,
      type: json['type'] as String?,
      file: json['file'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'doctor_id': doctorId,
        'type': type,
        'file': file,
      };
}

class HospitalDocumentModel {
  int? id;
  int? hospitalId;
  String? type;
  String? file;

  HospitalDocumentModel({
    this.id,
    this.hospitalId,
    this.type,
    this.file,
  });

  @override
  String toString() {
    return 'HospitalDocumentModel(id: $id, hospitalId: $hospitalId, type: $type, file: $file, )';
  }

  factory HospitalDocumentModel.fromJson(Map<String, dynamic> json) =>
      HospitalDocumentModel(
        id: json['id'] as int?,
        hospitalId: json['hospital_id'] as int?,
        type: json['type'] as String?,
        file: json['file'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hospital_id': hospitalId,
        'type': type,
        'file': file,
      };
}

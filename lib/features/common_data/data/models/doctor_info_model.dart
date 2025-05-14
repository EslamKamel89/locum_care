import 'package:locum_care/features/common_data/data/models/university_model.dart';

class DoctorInfoModel {
  int? id;
  int? doctorId;
  String? professionalLicenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  int? universityId;
  String? highestDegree;
  String? fieldOfStudy;
  int? graduationYear;
  String? workExperience;
  dynamic cv;
  String? biography;
  UniversityModel? university;

  DoctorInfoModel({
    this.id,
    this.doctorId,
    this.professionalLicenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.universityId,
    this.highestDegree,
    this.fieldOfStudy,
    this.graduationYear,
    this.workExperience,
    this.cv,
    this.biography,
    this.university,
  });

  @override
  String toString() {
    return 'DoctorInfoModel(id: $id, doctorId: $doctorId, professionalLicenseNumber: $professionalLicenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, universityId: $universityId, highestDegree: $highestDegree, fieldOfStudy: $fieldOfStudy, graduationYear: $graduationYear, workExperience: $workExperience, cv: $cv, biography: $biography, university: $university)';
  }

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      id: json['id'] as int?,
      doctorId: json['doctor_id'] as int?,
      professionalLicenseNumber: json['professional_license_number'] as String?,
      licenseState: json['license_state'] as String?,
      licenseIssueDate: json['license_issue_date'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      universityId: json['university_id'] as int?,
      highestDegree: json['highest_degree'] as String?,
      fieldOfStudy: json['field_of_study'] as String?,
      graduationYear:
          json['graduation_year'] == null
              ? null
              : json['graduation_year'] is String
              ? int.parse(json['graduation_year'])
              : json['graduation_year'],
      // graduationYear: json['graduation_year'] as int?,
      workExperience: json['work_experience'] as String?,
      cv: json['cv'] as dynamic,
      biography: json['biography'] as String?,
      university: json['university'] == null ? null : UniversityModel.fromJson(json['university']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctor_id': doctorId,
    'professional_license_number': professionalLicenseNumber,
    'license_state': licenseState,
    'license_issue_date': licenseIssueDate,
    'license_expiry_date': licenseExpiryDate,
    'university_id': universityId,
    'highest_degree': highestDegree,
    'field_of_study': fieldOfStudy,
    'graduation_year': graduationYear,
    'work_experience': workExperience,
    'cv': cv,
    'biography': biography,
  };
}

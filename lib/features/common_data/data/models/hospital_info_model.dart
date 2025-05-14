class HospitalInfoModel {
  int? id;
  int? hospitalId;
  String? licenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  String? operatingHours;
  String? staffingLevels;
  List<String>? servicesOffered;
  List<String>? notifcationPreferences;
  String? feedbackMethod;
  String? generalPolicy;
  String? emergencyPolicy;
  String? affiliations;

  HospitalInfoModel({
    this.id,
    this.hospitalId,
    this.licenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.operatingHours,
    this.staffingLevels,
    this.servicesOffered,
    this.notifcationPreferences,
    this.feedbackMethod,
    this.generalPolicy,
    this.emergencyPolicy,
    this.affiliations,
  });

  @override
  String toString() {
    return 'HospitalInfoModel(id: $id, hospitalId: $hospitalId, licenseNumber: $licenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, operatingHours: $operatingHours, )';
  }

  factory HospitalInfoModel.fromJson(Map<String, dynamic> json) {
    return HospitalInfoModel(
      id: json['id'] as int?,
      hospitalId: json['hospital_id'] as int?,
      licenseNumber: json['license_number'] as String?,
      licenseState: json['license_state'] as String?,
      licenseIssueDate: json['license_issue_date'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      operatingHours: json['operating_hours'] as String?,
      staffingLevels: json['staffing_levels'] as String?,
      servicesOffered: (json['services_offered'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      notifcationPreferences:
          (json['notifcation_preferences'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      feedbackMethod: json['feedback_method'] as String?,
      generalPolicy: json['general_policy'] as String?,
      emergencyPolicy: json['emergency_policy'] as String?,
      affiliations: json['affiliations'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'hospital_id': hospitalId,
        'license_number': licenseNumber,
        'license_state': licenseState,
        'license_issue_date': licenseIssueDate,
        'license_expiry_date': licenseExpiryDate,
        'operating_hours': operatingHours,
        'staffing_levels': staffingLevels,
        'services_offered': servicesOffered,
        'notifcation_preferences': notifcationPreferences,
        'feedback_method': feedbackMethod,
        'general_policy': generalPolicy,
        'emergency_policy': emergencyPolicy,
        'affiliations': affiliations,
      };
}

import 'package:locum_care/features/common_data/data/models/hospital_model.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';

class JobAddModel {
  int? id;
  String? title;
  int? hospitalId;
  int? specialityId;
  int? jobInfoId;
  String? jobType;
  String? location;
  String? description;
  String? responsibilities;
  String? qualifications;
  String? experienceRequired;
  String? salaryMin;
  String? salaryMax;
  String? benefits;
  String? workingHours;
  String? applicationDeadline;
  String? requiredDocuments;
  String? createdAt;
  String? updatedAt;
  //
  List<SkillModel>? skills;
  List<LanguageModel>? langs;
  SpecialtyModel? specialty;
  JobInfoModel? jobInfo;
  //
  HospitalModel? hospital;

  JobAddModel({
    this.id,
    this.title,
    this.hospitalId,
    this.specialityId,
    this.jobInfoId,
    this.jobType,
    this.location,
    this.description,
    this.responsibilities,
    this.qualifications,
    this.experienceRequired,
    this.salaryMin,
    this.salaryMax,
    this.benefits,
    this.workingHours,
    this.applicationDeadline,
    this.requiredDocuments,
    this.createdAt,
    this.updatedAt,
    this.skills,
    this.langs,
    this.specialty,
    this.jobInfo,
    this.hospital,
  });

  @override
  String toString() {
    return 'JobAddModel(id: $id, title: $title, hospitalId: $hospitalId, specialityId: $specialityId, jobInfoId: $jobInfoId, jobType: $jobType, location: $location, description: $description, responsibilities: $responsibilities, qualifications: $qualifications, experienceRequired: $experienceRequired, salaryMin: $salaryMin, salaryMax: $salaryMax, benefits: $benefits, workingHours: $workingHours, applicationDeadline: $applicationDeadline, requiredDocuments: $requiredDocuments, createdAt: $createdAt, updatedAt: $updatedAt , skills: $skills, langs: $langs, specialty: $specialty, jobInfo: $jobInfo, hospital: $hospital )';
  }

  factory JobAddModel.fromJson(Map<String, dynamic> json) => JobAddModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    hospitalId: json['hospital_id'] as int?,
    specialityId: json['speciality_id'] as int?,
    jobInfoId: json['job_info_id'] as int?,
    jobType: json['job_type'] as String?,
    location: json['location'] as String?,
    description: json['description'] as String?,
    responsibilities: json['responsibilities'] as String?,
    qualifications: json['qualifications'] as String?,
    experienceRequired: json['experience_required'] as String?,
    salaryMin: json['salary_min'] as String?,
    salaryMax: json['salary_max'] as String?,
    benefits: json['benefits'] as String?,
    workingHours: json['working_hours'] as String?,
    applicationDeadline: json['application_deadline'] as String?,
    requiredDocuments: json['required_documents'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    skills:
        json['skills'] == null
            ? null
            : (json['skills'] as List).map((json) => SkillModel.fromJson(json)).toList(),
    langs:
        json['langs'] == null
            ? null
            : (json['langs'] as List).map((json) => LanguageModel.fromJson(json)).toList(),
    specialty: json['specialty'] == null ? null : SpecialtyModel.fromJson(json['specialty']),
    jobInfo: json['job_info'] == null ? null : JobInfoModel.fromJson(json['job_info']),
    hospital: json['hospital'] == null ? null : HospitalModel.fromJson(json['hospital']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'hospital_id': hospitalId,
    'speciality_id': specialityId,
    'job_info_id': jobInfoId,
    'job_type': jobType,
    'location': location,
    'description': description,
    'responsibilities': responsibilities,
    'qualifications': qualifications,
    'experience_required': experienceRequired,
    'salary_min': salaryMin,
    'salary_max': salaryMax,
    'benefits': benefits,
    'working_hours': workingHours,
    'application_deadline': applicationDeadline,
    'required_documents': requiredDocuments,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'skills': skills,
    'langs': langs,
    'specialty': specialty,
    'job_info': jobInfo,
    'hospital': hospital,
  };
}

import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_care/features/common_data/data/models/job_info_model.dart';
import 'package:locum_care/features/common_data/data/models/language_model.dart';
import 'package:locum_care/features/common_data/data/models/skill_model.dart';
import 'package:locum_care/features/common_data/data/models/specialty_model.dart';

class DoctorModel {
  int? id;
  int? userId;
  int? specialtyId;
  int? jobInfoId;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? phone;
  bool? willingToRelocate;
  String? photo;
  DoctorInfoModel? doctorInfo;
  List<DoctorDocumentModel>? doctorDocuments;
  List<SkillModel>? skills;
  List<LanguageModel>? langs;
  SpecialtyModel? specialty;
  JobInfoModel? jobInfo;

  DoctorModel({
    this.id,
    this.userId,
    this.specialtyId,
    this.jobInfoId,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.phone,
    this.willingToRelocate,
    this.photo,
    this.doctorInfo,
    this.doctorDocuments,
    this.skills,
    this.langs,
    this.specialty,
    this.jobInfo,
  });

  @override
  String toString() {
    return 'DoctorModel(id: $id, userId: $userId, specialtyId: $specialtyId, jobInfoId: $jobInfoId, dateOfBirth: $dateOfBirth, gender: $gender, address: $address, phone: $phone, willingToRelocate: $willingToRelocate, photo: $photo, doctorInfo: $doctorInfo, doctorDocuments: $doctorDocuments, skills: $skills, langs: $langs, specialty: $specialty, jobInfo: $jobInfo )';
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    specialtyId: json['specialty_id'] as int?,
    jobInfoId: json['job_info_id'] as int?,
    dateOfBirth: json['date_of_birth'] as String?,
    gender: json['gender'] as String?,
    address: json['address'] as String?,
    phone: json['phone'] as String?,
    willingToRelocate: json['willing_to_relocate'] as bool?,
    photo: json['photo'] as String?,
    doctorInfo: json['doctor_info'] == null ? null : DoctorInfoModel.fromJson(json['doctor_info']),
    doctorDocuments:
        json['doctor_documents'] == null
            ? null
            : (json['doctor_documents'] as List)
                .map((json) => DoctorDocumentModel.fromJson(json))
                .toList(),
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
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'specialty_id': specialtyId,
    'job_info_id': jobInfoId,
    'date_of_birth': dateOfBirth,
    'gender': gender,
    'address': address,
    'phone': phone,
    'willing_to_relocate': willingToRelocate,
    'photo': photo,
    'doctor_info': doctorInfo,
    'doctor_documents': doctorDocuments,
    'skills': skills,
    'langs': langs,
    'specialty': specialty,
    'job_info': jobInfo,
  };
}

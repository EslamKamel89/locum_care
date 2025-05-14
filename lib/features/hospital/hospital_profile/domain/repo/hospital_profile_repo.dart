import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/api_service/upload_file_to_api.dart';
import 'package:locum_care/features/common_data/data/models/hospital_info_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_model.dart';

abstract class HospitalProfileRepo {
  Future<Either<Failure, HospitalModel>> updateOrCreateHospital({
    required HospitalParams params,
    required bool create,
    int? id,
  });
  Future<Either<Failure, HospitalInfoModel>> updateOrCreateHospitalInfo({
    required HospitalInfoParams params,
    required bool create,
    int? id,
  });
}

class HospitalInfoParams {
  String? licenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  String? operatingHours;

  HospitalInfoParams({
    this.licenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.operatingHours,
  });

  @override
  String toString() {
    return 'HospitalInfoParams(licenseNumber: $licenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, operatingHours: $operatingHours)';
  }

  factory HospitalInfoParams.fromJson(Map<String, dynamic> json) {
    return HospitalInfoParams(
      licenseNumber: json['license_number'] as String?,
      licenseState: json['license_state'] as String?,
      licenseIssueDate: json['license_issue_date'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      operatingHours: json['operating_hours'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'license_number': licenseNumber,
    'license_state': licenseState,
    'license_issue_date': licenseIssueDate,
    'license_expiry_date': licenseExpiryDate,
    'operating_hours': operatingHours,
  };
}

class HospitalParams {
  String? facilityName;
  String? type;
  String? contactPerson;
  String? contactEmail;
  String? contactPhone;
  String? address;
  String? servicesOffered;
  int? numberOfBeds;
  String? websiteUrl;
  int? yearEstablished;
  String? overview;
  File? photo;

  HospitalParams({
    this.facilityName,
    this.type,
    this.contactPerson,
    this.contactEmail,
    this.contactPhone,
    this.address,
    this.servicesOffered,
    this.numberOfBeds,
    this.websiteUrl,
    this.yearEstablished,
    this.overview,
    this.photo,
  });

  @override
  String toString() {
    return 'HospitalParams(facilityName: $facilityName, type: $type, contactPerson: $contactPerson, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address, servicesOffered: $servicesOffered, numberOfBeds: $numberOfBeds, websiteUrl: $websiteUrl, yearEstablished: $yearEstablished, overview: $overview, photo: $photo)';
  }

  Future<Map<String, dynamic>> toJson() async => {
    'facility_name': facilityName,
    'type': type,
    'contact_person': contactPerson,
    'contact_email': contactEmail,
    'contact_phone': contactPhone,
    'address': address,
    'services_offered': servicesOffered,
    'number_of_beds': numberOfBeds,
    'website_url': websiteUrl,
    'year_established': yearEstablished,
    'overview': overview,
    'photo': photo == null ? null : (await uploadFileToApi(photo!)),
  };
}

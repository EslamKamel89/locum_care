import 'package:locum_care/features/common_data/data/models/hospital_document_model.dart';
import 'package:locum_care/features/common_data/data/models/hospital_info_model.dart';

class HospitalModel {
  int? id;
  int? userId;
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
  String? photo;
  HospitalInfoModel? hospitalInfo;
  List<HospitalDocumentModel>? hospitalDocuments;

  HospitalModel({
    this.id,
    this.userId,
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
    this.hospitalInfo,
    this.hospitalDocuments,
  });

  @override
  String toString() {
    return 'HospitalModel(id: $id, userId: $userId, facilityName: $facilityName, type: $type, contactPerson: $contactPerson, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address, servicesOffered: $servicesOffered, numberOfBeds: $numberOfBeds, websiteUrl: $websiteUrl, yearEstablished: $yearEstablished, overview: $overview, photo: $photo,  hospitalInfo: $hospitalInfo, hospitalDocuments: $hospitalDocuments)';
  }

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    facilityName: json['facility_name'] as String?,
    type: json['type'] as String?,
    contactPerson: json['contact_person'] as String?,
    contactEmail: json['contact_email'] as String?,
    contactPhone: json['contact_phone'] as String?,
    address: json['address'] as String?,
    servicesOffered: json['services_offered'] as String?,
    numberOfBeds:
        json['number_of_beds'] == null
            ? null
            : json['number_of_beds'] is String
            ? int.parse(json['number_of_beds'])
            : json['number_of_beds'] as int?,
    websiteUrl: json['website_url'] as String?,
    yearEstablished:
        json['year_established'] == null
            ? null
            : json['year_established'] is String
            ? int.parse(json['year_established'])
            : json['year_established'] as int?,
    overview: json['overview'] as String?,
    photo: json['photo'] as String?,
    hospitalInfo:
        json['hospital_info'] == null ? null : HospitalInfoModel.fromJson(json['hospital_info']),
    hospitalDocuments:
        json['hospital_documents'] == null
            ? []
            : (json['hospital_documents'] as List)
                .map((json) => HospitalDocumentModel.fromJson(json))
                .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
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
    'photo': photo,
    'hospital_info': hospitalInfo?.toJson(),
    'hospital_documents': hospitalDocuments?.map((hospitalDocument) => hospitalDocument.toJson()),
  };
}

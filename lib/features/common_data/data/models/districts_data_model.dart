// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:locum_care/features/common_data/data/models/district_model.dart';

class DistrictsDataModel {
  String? stateName;
  List<DistrictModel?>? districts;
  DistrictsDataModel({this.stateName, this.districts});

  DistrictsDataModel copyWith({String? stateName, List<DistrictModel?>? districts}) {
    return DistrictsDataModel(
      stateName: stateName ?? this.stateName,
      districts: districts ?? this.districts,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'state_name': stateName,
      'districts': districts?.map((x) => x?.toJson()).toList(),
    };
  }

  factory DistrictsDataModel.fromJson(Map<String, dynamic> json) {
    List<DistrictModel?>? districts;
    if (json['districts'] != null) {
      districts = (json['districts'] as List).map((json) => DistrictModel.fromJson(json)).toList();
    }
    return DistrictsDataModel(
      stateName: json['state_name'] != null ? json['state_name'] as String : null,
      districts: districts,
    );
  }

  @override
  String toString() => 'DistrictsDataModel(stateName: $stateName, districts: $districts)';
}

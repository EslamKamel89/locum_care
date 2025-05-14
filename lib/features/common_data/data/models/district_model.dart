// ignore_for_file: public_member_api_docs, sort_constructors_first

class DistrictModel {
  int? id;
  String? name;
  DistrictModel({
    this.id,
    this.name,
  });

  DistrictModel copyWith({
    int? id,
    String? name,
  }) {
    return DistrictModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'DistrictModel(id: $id, name: $name)';
}

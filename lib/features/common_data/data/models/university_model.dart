// ignore_for_file: public_member_api_docs, sort_constructors_first

class UniversityModel {
  int? id;
  String? name;
  UniversityModel({
    this.id,
    this.name,
  });

  UniversityModel copyWith({
    int? id,
    String? name,
  }) {
    return UniversityModel(
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

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'UniversityModel(id: $id, name: $name)';
}

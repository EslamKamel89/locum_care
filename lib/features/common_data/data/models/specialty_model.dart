// ignore_for_file: public_member_api_docs, sort_constructors_first

class SpecialtyModel {
  int? id;
  String? name;
  SpecialtyModel({
    this.id,
    this.name,
  });

  SpecialtyModel copyWith({
    int? id,
    String? name,
  }) {
    return SpecialtyModel(
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

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'SpecialtyModel(id: $id, name: $name)';
}

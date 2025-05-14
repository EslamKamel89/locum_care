// ignore_for_file: public_member_api_docs, sort_constructors_first

class JobInfoModel {
  int? id;
  String? name;
  JobInfoModel({
    this.id,
    this.name,
  });

  JobInfoModel copyWith({
    int? id,
    String? name,
  }) {
    return JobInfoModel(
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

  factory JobInfoModel.fromJson(Map<String, dynamic> json) {
    return JobInfoModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'JobInfoModel(id: $id, name: $name)';
}

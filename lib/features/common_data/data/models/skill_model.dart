class SkillModel {
  int? id;
  String? name;

  SkillModel({this.id, this.name});

  @override
  String toString() => 'SkillModel(id: $id, name: $name)';

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

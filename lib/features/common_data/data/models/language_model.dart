class LanguageModel {
  int? id;
  String? name;

  LanguageModel({this.id, this.name});

  @override
  String toString() => 'LanguageModel(id: $id, name: $name)';

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

class StateModel {
  int? id;
  String? name;
  StateModel({
    this.id,
    this.name,
  });

  StateModel copyWith({
    int? id,
    String? name,
  }) {
    return StateModel(
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

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  String toString() => 'StateModel(id: $id, name: $name)';
}

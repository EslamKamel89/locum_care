class SupportModel {
  String? sender;
  String? content;
  String? createdAt;

  SupportModel({this.sender, this.content, this.createdAt});

  @override
  String toString() {
    return 'SupportModel(sender: $sender, content: $content, createdAt: $createdAt)';
  }

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        sender: json['sender'] as String?,
        content: json['content'] as String?,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'content': content,
        'created_at': createdAt,
      };
}

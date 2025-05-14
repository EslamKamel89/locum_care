import 'dart:convert';

class JobAddNotificationPayload {
  int? id;

  JobAddNotificationPayload({this.id});

  @override
  String toString() => 'JobAddNotificationPayload(id: $id)';

  factory JobAddNotificationPayload.fromJson(Map<String, dynamic> json) {
    return JobAddNotificationPayload(
      id: json['id'] as int?,
    );
  }
  factory JobAddNotificationPayload.fromJsonRaw(String jsonRaw) {
    final json = jsonDecode(jsonRaw);
    return JobAddNotificationPayload(
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

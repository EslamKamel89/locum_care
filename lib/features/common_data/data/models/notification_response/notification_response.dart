class NotificationResponse<T> {
  T? payload;
  String? routeName;

  NotificationResponse({this.payload, this.routeName});

  @override
  String toString() {
    return 'NotificationResponse(payload: $payload, routeName: $routeName)';
  }

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      routeName: json['routeName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'payload': payload,
        'routeName': routeName,
      };
}

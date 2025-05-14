class NotSeenCountModel {
  int? notSeenCount;

  NotSeenCountModel({this.notSeenCount});

  @override
  String toString() => 'NotSeenCountModel(notSeenCount: $notSeenCount)';

  factory NotSeenCountModel.fromJson(Map<String, dynamic> json) {
    return NotSeenCountModel(
      notSeenCount: json['not_seen_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'not_seen_count': notSeenCount,
      };
}

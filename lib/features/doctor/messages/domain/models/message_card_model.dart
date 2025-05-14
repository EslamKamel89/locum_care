class MessageCardModel {
  int? otherUserId;
  int? notSeenCount;
  String? otherUserName;
  String? otherUserType;
  String? otherUserPhoto;
  int? notSeenCountTotal;

  MessageCardModel({
    this.otherUserId,
    this.notSeenCount,
    this.otherUserName,
    this.otherUserType,
    this.otherUserPhoto,
    this.notSeenCountTotal,
  });

  @override
  String toString() {
    return 'MessageCardModel(otherUserId: $otherUserId, notSeenCount: $notSeenCount, otherUserName: $otherUserName, otherUserType: $otherUserType, otherUserPhoto: $otherUserPhoto , notSeenCountTotal: $notSeenCountTotal)';
  }

  factory MessageCardModel.fromJson(Map<String, dynamic> json) {
    return MessageCardModel(
      otherUserId: json['other_user_id'] as int?,
      notSeenCount: json['not_seen_count'] as int?,
      otherUserName: json['other_user_name'] as String?,
      otherUserType: json['other_user_type'] as String?,
      otherUserPhoto: json['other_user_photo'] as String?,
      notSeenCountTotal: json['not_seen_count_total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'other_user_id': otherUserId,
        'not_seen_count': notSeenCount,
        'other_user_name': otherUserName,
        'other_user_type': otherUserType,
        'other_user_photo': otherUserPhoto,
        'not_seen_count_total': notSeenCountTotal,
      };
}

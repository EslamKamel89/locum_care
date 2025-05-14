// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locum_care/features/auth/data/models/user_model.dart';

class CommentModel {
  int? id;
  int? userId;
  int? parentId;
  String? commentableType;
  int? commentableId;
  String? content;
  int? rating;
  String? createdAt;
  UserModel? user;
  List<CommentModel?>? children;

  CommentModel({
    this.id,
    this.userId,
    this.parentId,
    this.commentableType,
    this.commentableId,
    this.content,
    this.rating,
    this.createdAt,
    this.user,
    this.children,
  });

  @override
  String toString() {
    return 'CommentModel(id: $id, userId: $userId, parentId: $parentId, commentableType: $commentableType, commentableId: $commentableId, content: $content, rating: $rating, createdAt: $createdAt, user: $user, children: $children)';
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    parentId: json['parent_id'] as int?,
    commentableType: json['commentable_type'] as String?,
    commentableId: json['commentable_id'] as int?,
    content: json['content'] as String?,
    rating: json['rating'] as int?,
    createdAt: json['created_at'] as String?,
    user: json['user'] == null ? null : UserModel.fromJson(json['user']),
    children:
        json['children'] == null
            ? null
            : (json['children'] as List).map((json) => CommentModel.fromJson(json)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'parent_id': parentId,
    'commentable_type': commentableType,
    'commentable_id': commentableId,
    'content': content,
    'rating': rating,
    'created_at': createdAt,
    'user': user,
    'children': children,
  };

  CommentModel copyWith({
    int? id,
    int? userId,
    int? parentId,
    String? commentableType,
    int? commentableId,
    String? content,
    int? rating,
    String? createdAt,
    UserModel? user,
    List<CommentModel?>? children,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      parentId: parentId ?? this.parentId,
      commentableType: commentableType ?? this.commentableType,
      commentableId: commentableId ?? this.commentableId,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      children: children ?? this.children,
    );
  }
}

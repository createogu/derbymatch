import 'package:derbymatch/features/player/models/player_model.dart';

class CommentModel {
  final int post_id;
  final int comment_id;
  final String content;
  final int user_id;
  final bool is_like;
  final int like_cnt;
  final int reply_cnt;

  final DateTime created_at;
  final DateTime updated_at;
  final PlayerModel commenter;

//<editor-fold desc="Data Methods">
  const CommentModel({
    required this.post_id,
    required this.comment_id,
    required this.content,
    required this.user_id,
    required this.is_like,
    required this.like_cnt,
    required this.reply_cnt,
    required this.created_at,
    required this.updated_at,
    required this.commenter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentModel &&
          runtimeType == other.runtimeType &&
          post_id == other.post_id &&
          comment_id == other.comment_id &&
          content == other.content &&
          user_id == other.user_id &&
          is_like == other.is_like &&
          like_cnt == other.like_cnt &&
          reply_cnt == other.reply_cnt &&
          created_at == other.created_at &&
          updated_at == other.updated_at &&
          commenter == other.commenter);

  @override
  int get hashCode =>
      post_id.hashCode ^
      comment_id.hashCode ^
      content.hashCode ^
      user_id.hashCode ^
      is_like.hashCode ^
      like_cnt.hashCode ^
      reply_cnt.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      commenter.hashCode;

  @override
  String toString() {
    return 'CommentModel{' +
        ' post_id: $post_id,' +
        ' comment_id: $comment_id,' +
        ' content: $content,' +
        ' user_id: $user_id,' +
        ' is_like: $is_like,' +
        ' like_cnt: $like_cnt,' +
        ' reply_cnt: $reply_cnt,' +
        ' created_at: $created_at,' +
        ' updated_at: $updated_at,' +
        ' commenter: $commenter,' +
        '}';
  }

  CommentModel copyWith({
    int? post_id,
    int? comment_id,
    String? content,
    int? user_id,
    bool? is_like,
    int? like_cnt,
    int? reply_cnt,
    DateTime? created_at,
    DateTime? updated_at,
    PlayerModel? commenter,
  }) {
    return CommentModel(
      post_id: post_id ?? this.post_id,
      comment_id: comment_id ?? this.comment_id,
      content: content ?? this.content,
      user_id: user_id ?? this.user_id,
      is_like: is_like ?? this.is_like,
      like_cnt: like_cnt ?? this.like_cnt,
      reply_cnt: reply_cnt ?? this.reply_cnt,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      commenter: commenter ?? this.commenter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.post_id,
      'comment_id': this.comment_id,
      'content': this.content,
      'user_id': this.user_id,
      'is_like': this.is_like,
      'like_cnt': this.like_cnt,
      'reply_cnt': this.reply_cnt,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
      'commenter': this.commenter,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    try {
      return CommentModel(
        post_id: map['post_id'] as int,
        comment_id: map['comment_id'] as int,
        content: map['content'] as String,
        user_id: map['user_id'] as int,
        is_like: (map['is_like'] as int) == 1,
        like_cnt:
            map['like_cnt'] != null ? int.parse(map['like_cnt'].toString()) : 0,
        reply_cnt: map['reply_cnt'] != null
            ? int.parse(map['reply_cnt'].toString())
            : 0,
        created_at: DateTime.parse(map['created_at']),
        updated_at: DateTime.parse(map['updated_at']),
        commenter: PlayerModel.fromMap(map['commenter']),
      );
    } catch (e) {
      // 에러 처리 로직을 적절히 추가하세요.
      print('Error parsing CommentModel: $e');
      rethrow; // or return a default instance
    }
  }

//</editor-fold>
}

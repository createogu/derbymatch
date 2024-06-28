import 'package:derbymatch/features/player/models/player_model.dart';

class ReplyModel {
  final int post_id;
  final int reply_id;
  final int parent_reply_id;
  final String content;
  final int user_id;
  final bool is_like;
  final int like_cnt;

  final DateTime created_at;
  final DateTime updated_at;
  final PlayerModel replyer;

//<editor-fold desc="Data Methods">
  const ReplyModel({
    required this.post_id,
    required this.reply_id,
    required this.parent_reply_id,
    required this.content,
    required this.user_id,
    required this.is_like,
    required this.like_cnt,
    required this.created_at,
    required this.updated_at,
    required this.replyer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReplyModel &&
          runtimeType == other.runtimeType &&
          post_id == other.post_id &&
          reply_id == other.reply_id &&
          parent_reply_id == other.parent_reply_id &&
          content == other.content &&
          user_id == other.user_id &&
          is_like == other.is_like &&
          like_cnt == other.like_cnt &&
          created_at == other.created_at &&
          updated_at == other.updated_at &&
          replyer == other.replyer);

  @override
  int get hashCode =>
      post_id.hashCode ^
      reply_id.hashCode ^
      parent_reply_id.hashCode ^
      content.hashCode ^
      user_id.hashCode ^
      is_like.hashCode ^
      like_cnt.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      replyer.hashCode;

  @override
  String toString() {
    return 'ReplyModel{' +
        ' post_id: $post_id,' +
        ' reply_id: $reply_id,' +
        ' parent_reply_id: $parent_reply_id,' +
        ' content: $content,' +
        ' user_id: $user_id,' +
        ' is_like: $is_like,' +
        ' like_cnt: $like_cnt,' +
        ' created_at: $created_at,' +
        ' updated_at: $updated_at,' +
        ' replyer: $replyer,' +
        '}';
  }

  ReplyModel copyWith({
    int? post_id,
    int? reply_id,
    int? parent_reply_id,
    String? content,
    int? user_id,
    bool? is_like,
    int? like_cnt,
    DateTime? created_at,
    DateTime? updated_at,
    PlayerModel? replyer,
  }) {
    return ReplyModel(
      post_id: post_id ?? this.post_id,
      reply_id: reply_id ?? this.reply_id,
      parent_reply_id: parent_reply_id ?? this.parent_reply_id,
      content: content ?? this.content,
      user_id: user_id ?? this.user_id,
      is_like: is_like ?? this.is_like,
      like_cnt: like_cnt ?? this.like_cnt,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      replyer: replyer ?? this.replyer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.post_id,
      'reply_id': this.reply_id,
      'parent_reply_id': this.parent_reply_id,
      'content': this.content,
      'user_id': this.user_id,
      'is_like': this.is_like,
      'like_cnt': this.like_cnt,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
      'replyer': this.replyer,
    };
  }

  factory ReplyModel.fromMap(Map<String, dynamic> map) {
    try {
      return ReplyModel(
        post_id: map['post_id'] as int,
        reply_id: map['reply_id'] as int,
        parent_reply_id: map['parent_reply_id'] != null
            ? int.parse(map['parent_reply_id'].toString())
            : 0,
        content: map['content'] as String,
        user_id: map['user_id'] as int,
        is_like: (map['is_like'] as int) == 1,
        like_cnt:
            map['like_cnt'] != null ? int.parse(map['like_cnt'].toString()) : 0,
        created_at: DateTime.parse(map['created_at']),
        updated_at: DateTime.parse(map['updated_at']),
        replyer: PlayerModel.fromMap(map['replyer']),
      );
    } catch (e) {
      // 에러 처리 로직을 적절히 추가하세요.
      print('Error parsing ReplyModel: $e');
      rethrow; // or return a default instance
    }
  }

//</editor-fold>
}

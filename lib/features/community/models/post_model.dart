import 'package:derbymatch/features/player/models/player_model.dart';

class PostModel {
  final int post_id;
  final int channel_id;
  final String channel_name;
  final String title;
  final String content;
  final int user_id;
  final int view_cnt;
  final bool is_like;
  final int like_cnt;
  final int comment_cnt;
  final DateTime created_at;
  final DateTime updated_at;
  final PlayerModel writer;

//<editor-fold desc="Data Methods">
  const PostModel({
    required this.post_id,
    required this.channel_id,
    required this.channel_name,
    required this.title,
    required this.content,
    required this.user_id,
    required this.view_cnt,
    required this.is_like,
    required this.like_cnt,
    required this.comment_cnt,
    required this.created_at,
    required this.updated_at,
    required this.writer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostModel &&
          runtimeType == other.runtimeType &&
          post_id == other.post_id &&
          channel_id == other.channel_id &&
          channel_name == other.channel_name &&
          title == other.title &&
          content == other.content &&
          user_id == other.user_id &&
          view_cnt == other.view_cnt &&
          is_like == other.is_like &&
          like_cnt == other.like_cnt &&
          comment_cnt == other.comment_cnt &&
          created_at == other.created_at &&
          updated_at == other.updated_at &&
          writer == other.writer);

  @override
  int get hashCode =>
      post_id.hashCode ^
      channel_id.hashCode ^
      channel_name.hashCode ^
      title.hashCode ^
      content.hashCode ^
      user_id.hashCode ^
      view_cnt.hashCode ^
      is_like.hashCode ^
      like_cnt.hashCode ^
      comment_cnt.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      writer.hashCode;

  @override
  String toString() {
    return 'PostModel{' +
        ' post_id: $post_id,' +
        ' channel_id: $channel_id,' +
        ' channel_name: $channel_name,' +
        ' title: $title,' +
        ' content: $content,' +
        ' user_id: $user_id,' +
        ' view_cnt: $view_cnt,' +
        ' is_like: $is_like,' +
        ' like_cnt: $like_cnt,' +
        ' comment_cnt: $comment_cnt,' +
        ' created_at: $created_at,' +
        ' updated_at: $updated_at,' +
        ' writer: $writer,' +
        '}';
  }

  PostModel copyWith({
    int? post_id,
    int? channel_id,
    String? channel_name,
    String? title,
    String? content,
    int? user_id,
    int? view_cnt,
    bool? is_like,
    int? like_cnt,
    int? comment_cnt,
    DateTime? created_at,
    DateTime? updated_at,
    PlayerModel? writer,
  }) {
    return PostModel(
      post_id: post_id ?? this.post_id,
      channel_id: channel_id ?? this.channel_id,
      channel_name: channel_name ?? this.channel_name,
      title: title ?? this.title,
      content: content ?? this.content,
      user_id: user_id ?? this.user_id,
      view_cnt: view_cnt ?? this.view_cnt,
      is_like: is_like ?? this.is_like,
      like_cnt: like_cnt ?? this.like_cnt,
      comment_cnt: comment_cnt ?? this.comment_cnt,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      writer: writer ?? this.writer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.post_id,
      'channel_id': this.channel_id,
      'channel_name': this.channel_name,
      'title': this.title,
      'content': this.content,
      'user_id': this.user_id,
      'view_cnt': this.view_cnt,
      'is_like': this.is_like,
      'like_cnt': this.like_cnt,
      'comment_cnt': this.comment_cnt,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
      'writer': this.writer,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      post_id: map['post_id'] as int,
      channel_id: map['channel_id'] as int,
      channel_name: map['channel_name'] ?? '' as String,
      title: map['title'] as String,
      content: map['content'] as String,
      user_id: map['user_id'] as int,
      view_cnt: map['view_cnt'] as int,
      is_like: (map['is_like'] as int) == 1 ? true : false,
      like_cnt: map['like_cnt'] ?? 0 as int,
      comment_cnt: map['comment_cnt'] != null
          ? int.parse(map['comment_cnt'].toString())
          : 0,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
      writer: PlayerModel.fromMap(
          map['writer'] as Map<String, dynamic>), // PlayerModel 인스턴스 생성
    );
  }

//</editor-fold>
}

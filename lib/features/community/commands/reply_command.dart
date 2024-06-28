class ReplyCommand {
  final int post_id;
  final int? comment_id;
  final String content;

//<editor-fold desc="Data Methods">
  const ReplyCommand({
    required this.post_id,
    this.comment_id,
    required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReplyCommand &&
          runtimeType == other.runtimeType &&
          post_id == other.post_id &&
          comment_id == other.comment_id &&
          content == other.content);

  @override
  int get hashCode => post_id.hashCode ^ comment_id.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'ReplyCommand{' +
        ' post_id: $post_id,' +
        ' comment_id: $comment_id,' +
        ' content: $content,' +
        '}';
  }

  ReplyCommand copyWith({
    int? post_id,
    int? comment_id,
    String? content,
  }) {
    return ReplyCommand(
      post_id: post_id ?? this.post_id,
      comment_id: comment_id ?? this.comment_id,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.post_id,
      'comment_id': this.comment_id,
      'content': this.content,
    };
  }

  factory ReplyCommand.fromMap(Map<String, dynamic> map) {
    return ReplyCommand(
      post_id: map['post_id'] as int,
      comment_id: map['comment_id'] as int,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}

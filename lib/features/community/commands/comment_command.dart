class CommentCommand {
  final int post_id;
  final String content;

//<editor-fold desc="Data Methods">
  const CommentCommand({
    required this.post_id,
    required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentCommand &&
          runtimeType == other.runtimeType &&
          post_id == other.post_id &&
          content == other.content);

  @override
  int get hashCode => post_id.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'CommentCommand{' +
        ' post_id: $post_id,' +
        ' content: $content,' +
        '}';
  }

  CommentCommand copyWith({
    int? post_id,
    String? content,
  }) {
    return CommentCommand(
      post_id: post_id ?? this.post_id,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.post_id,
      'content': this.content,
    };
  }

  factory CommentCommand.fromMap(Map<String, dynamic> map) {
    return CommentCommand(
      post_id: map['post_id'] as int,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}

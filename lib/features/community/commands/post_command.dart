class PostCommand {
  final int channel_id;
  final String title;
  final String content;
  final List<String> tags;

//<editor-fold desc="Data Methods">
  const PostCommand({
    required this.channel_id,
    required this.title,
    required this.content,
    required this.tags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostCommand &&
          runtimeType == other.runtimeType &&
          channel_id == other.channel_id &&
          title == other.title &&
          content == other.content &&
          tags == other.tags);

  @override
  int get hashCode =>
      channel_id.hashCode ^ title.hashCode ^ content.hashCode ^ tags.hashCode;

  @override
  String toString() {
    return 'PostCommand{' +
        ' channel_id: $channel_id,' +
        ' title: $title,' +
        ' content: $content,' +
        ' tags: $tags,' +
        '}';
  }

  PostCommand copyWith({
    int? channel_id,
    String? title,
    String? content,
    List<String>? tags,
  }) {
    return PostCommand(
      channel_id: channel_id ?? this.channel_id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'channel_id': this.channel_id,
      'title': this.title,
      'content': this.content,
      'tags': this.tags,
    };
  }

  factory PostCommand.fromMap(Map<String, dynamic> map) {
    return PostCommand(
      channel_id: map['channel_id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      tags: map['tags'] as List<String>,
    );
  }

//</editor-fold>
}

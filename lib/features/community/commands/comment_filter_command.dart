class CommentFilterCommand {
  final int page;
  final int pageSize;
  final int post_id;

//<editor-fold desc="Data Methods">
  const CommentFilterCommand({
    required this.page,
    required this.pageSize,
    required this.post_id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentFilterCommand &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          post_id == other.post_id);

  @override
  int get hashCode => page.hashCode ^ pageSize.hashCode ^ post_id.hashCode;

  @override
  String toString() {
    return 'ReplyFilterCommand{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' post_id: $post_id,' +
        '}';
  }

  CommentFilterCommand copyWith({
    int? page,
    int? pageSize,
    int? post_id,
  }) {
    return CommentFilterCommand(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      post_id: post_id ?? this.post_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'post_id': this.post_id,
    };
  }

  factory CommentFilterCommand.fromMap(Map<String, dynamic> map) {
    return CommentFilterCommand(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      post_id: map['post_id'] as int,
    );
  }

//</editor-fold>
}

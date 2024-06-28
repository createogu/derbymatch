class ReplyFilterCommand {
  final int page;
  final int pageSize;
  final int post_id;
  final int comment_id;

//<editor-fold desc="Data Methods">
  const ReplyFilterCommand({
    required this.page,
    required this.pageSize,
    required this.post_id,
    required this.comment_id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReplyFilterCommand &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          post_id == other.post_id &&
          comment_id == other.comment_id);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      post_id.hashCode ^
      comment_id.hashCode;

  @override
  String toString() {
    return 'ReplyFilterCommand{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' post_id: $post_id,' +
        ' comment_id: $comment_id,' +
        '}';
  }

  ReplyFilterCommand copyWith({
    int? page,
    int? pageSize,
    int? post_id,
    int? comment_id,
  }) {
    return ReplyFilterCommand(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      post_id: post_id ?? this.post_id,
      comment_id: comment_id ?? this.comment_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'post_id': this.post_id,
      'comment_id': this.comment_id,
    };
  }

  factory ReplyFilterCommand.fromMap(Map<String, dynamic> map) {
    return ReplyFilterCommand(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      post_id: map['post_id'] as int,
      comment_id: map['comment_id'] as int,
    );
  }

//</editor-fold>
}

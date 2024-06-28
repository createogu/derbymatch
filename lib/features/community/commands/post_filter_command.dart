class PostFilterCommand {
  final int page;
  final int pageSize;
  final List<int> channels;

//<editor-fold desc="Data Methods">
  const PostFilterCommand({
    required this.page,
    required this.pageSize,
    required this.channels,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostFilterCommand &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          channels == other.channels);

  @override
  int get hashCode => page.hashCode ^ pageSize.hashCode ^ channels.hashCode;

  @override
  String toString() {
    return 'PostFilterCommand{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' channels: $channels,' +
        '}';
  }

  PostFilterCommand copyWith({
    int? page,
    int? pageSize,
    List<int>? channels,
  }) {
    return PostFilterCommand(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      channels: channels ?? this.channels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'channels': this.channels,
    };
  }

  factory PostFilterCommand.fromMap(Map<String, dynamic> map) {
    return PostFilterCommand(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      channels: map['channels'] as List<int>,
    );
  }

//</editor-fold>
}

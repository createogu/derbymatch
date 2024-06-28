class MatchFilterCommand {
  final int page;
  final int pageSize;
  final List<String> match_type;
  final String match_date;

//<editor-fold desc="Data Methods">
  const MatchFilterCommand({
    required this.page,
    required this.pageSize,
    required this.match_type,
    required this.match_date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchFilterCommand &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          match_type == other.match_type &&
          match_date == other.match_date);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      match_type.hashCode ^
      match_date.hashCode;

  @override
  String toString() {
    return 'MatchFilterCommand{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' match_type: $match_type,' +
        ' match_date: $match_date,' +
        '}';
  }

  MatchFilterCommand copyWith({
    int? page,
    int? pageSize,
    List<String>? match_type,
    String? match_date,
  }) {
    return MatchFilterCommand(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      match_type: match_type ?? this.match_type,
      match_date: match_date ?? this.match_date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'match_type': this.match_type,
      'match_date': this.match_date,
    };
  }

  factory MatchFilterCommand.fromMap(Map<String, dynamic> map) {
    return MatchFilterCommand(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      match_type: map['match_type'] as List<String>,
      match_date: map['match_date'] as String,
    );
  }

//</editor-fold>
}

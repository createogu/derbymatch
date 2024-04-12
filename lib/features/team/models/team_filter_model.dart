class TeamFilterModel {
  final int page;
  final int pageSize;
  final List<String> division;
  final String addressCode;

//<editor-fold desc="Data Methods">
  const TeamFilterModel({
    required this.page,
    required this.pageSize,
    required this.division,
    required this.addressCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamFilterModel &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          division == other.division &&
          addressCode == other.addressCode);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      division.hashCode ^
      addressCode.hashCode;

  @override
  String toString() {
    return 'TeamFilterModel{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' division: $division,' +
        ' addressCode: $addressCode,' +
        '}';
  }

  TeamFilterModel copyWith({
    int? page,
    int? pageSize,
    List<String>? division,
    String? addressCode,
  }) {
    return TeamFilterModel(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      division: division ?? this.division,
      addressCode: addressCode ?? this.addressCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'division': this.division,
      'addressCode': this.addressCode,
    };
  }

  factory TeamFilterModel.fromMap(Map<String, dynamic> map) {
    return TeamFilterModel(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      division: map['division'] as List<String>,
      addressCode: map['addressCode'] as String,
    );
  }

//</editor-fold>
}

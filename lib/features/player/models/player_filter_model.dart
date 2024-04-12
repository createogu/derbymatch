class PlayerFilterModel {
  final int page;
  final int pageSize;
  final List<String> gender;
  final List<String> division;
  final List<String> positions;
  final String addressCode;
  final double beginHeight;
  final double endHeight;
  final double beginWeight;
  final double endWeight;

//<editor-fold desc="Data Methods">
  const PlayerFilterModel({
    required this.page,
    required this.pageSize,
    required this.gender,
    required this.division,
    required this.positions,
    required this.addressCode,
    required this.beginHeight,
    required this.endHeight,
    required this.beginWeight,
    required this.endWeight,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerFilterModel &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          gender == other.gender &&
          division == other.division &&
          positions == other.positions &&
          addressCode == other.addressCode &&
          beginHeight == other.beginHeight &&
          endHeight == other.endHeight &&
          beginWeight == other.beginWeight &&
          endWeight == other.endWeight);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      gender.hashCode ^
      division.hashCode ^
      positions.hashCode ^
      addressCode.hashCode ^
      beginHeight.hashCode ^
      endHeight.hashCode ^
      beginWeight.hashCode ^
      endWeight.hashCode;

  @override
  String toString() {
    return 'PlayerFilterModel{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' gender: $gender,' +
        ' division: $division,' +
        ' positions: $positions,' +
        ' addressCode: $addressCode,' +
        ' beginHeight: $beginHeight,' +
        ' endHeight: $endHeight,' +
        ' beginWeight: $beginWeight,' +
        ' endWeight: $endWeight,' +
        '}';
  }

  PlayerFilterModel copyWith({
    int? page,
    int? pageSize,
    List<String>? gender,
    List<String>? division,
    List<String>? positions,
    String? addressCode,
    double? beginHeight,
    double? endHeight,
    double? beginWeight,
    double? endWeight,
  }) {
    return PlayerFilterModel(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      gender: gender ?? this.gender,
      division: division ?? this.division,
      positions: positions ?? this.positions,
      addressCode: addressCode ?? this.addressCode,
      beginHeight: beginHeight ?? this.beginHeight,
      endHeight: endHeight ?? this.endHeight,
      beginWeight: beginWeight ?? this.beginWeight,
      endWeight: endWeight ?? this.endWeight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'gender': this.gender,
      'division': this.division,
      'positions': this.positions,
      'addressCode': this.addressCode,
      'beginHeight': this.beginHeight,
      'endHeight': this.endHeight,
      'beginWeight': this.beginWeight,
      'endWeight': this.endWeight,
    };
  }

  factory PlayerFilterModel.fromMap(Map<String, dynamic> map) {
    return PlayerFilterModel(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      gender: map['gender'] as List<String>,
      division: map['division'] as List<String>,
      positions: map['positions'] as List<String>,
      addressCode: map['addressCode'] as String,
      beginHeight: map['beginHeight'] as double,
      endHeight: map['endHeight'] as double,
      beginWeight: map['beginWeight'] as double,
      endWeight: map['endWeight'] as double,
    );
  }

//</editor-fold>
}

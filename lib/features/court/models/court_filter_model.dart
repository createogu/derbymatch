class CourtFilterModel {
  final int page;
  final int pageSize;
  final List<String> court_type;
  final List<String> court_type_detail;
  final String court_name;
  final String latitude;
  final String longitude;

//<editor-fold desc="Data Methods">
  const CourtFilterModel({
    required this.page,
    required this.pageSize,
    required this.court_type,
    required this.court_type_detail,
    required this.court_name,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourtFilterModel &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          court_type == other.court_type &&
          court_type_detail == other.court_type_detail &&
          court_name == other.court_name &&
          latitude == other.latitude &&
          longitude == other.longitude);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      court_type.hashCode ^
      court_type_detail.hashCode ^
      court_name.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;

  @override
  String toString() {
    return 'CourtFilterModel{' +
        ' page: $page,' +
        ' pageSize: $pageSize,' +
        ' court_type: $court_type,' +
        ' court_type_detail: $court_type_detail,' +
        ' court_name: $court_name,' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        '}';
  }

  CourtFilterModel copyWith({
    int? page,
    int? pageSize,
    List<String>? court_type,
    List<String>? court_type_detail,
    String? court_name,
    String? latitude,
    String? longitude,
  }) {
    return CourtFilterModel(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      court_type: court_type ?? this.court_type,
      court_type_detail: court_type_detail ?? this.court_type_detail,
      court_name: court_name ?? this.court_name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'pageSize': this.pageSize,
      'court_type': this.court_type,
      'court_type_detail': this.court_type_detail,
      'court_name': this.court_name,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory CourtFilterModel.fromMap(Map<String, dynamic> map) {
    return CourtFilterModel(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      court_type: map['court_type'] as List<String>,
      court_type_detail: map['court_type_detail'] as List<String>,
      court_name: map['court_name'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

//</editor-fold>
}

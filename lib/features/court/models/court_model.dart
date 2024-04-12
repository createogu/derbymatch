class CourtModel {
  final int court_id;
  final String court_type;
  final String court_type_detail;
  final String court_name;
  final String city_code;
  final String district_code;
  final String postal_code;
  final String road_address;
  final String address_code;
  final String latitude;
  final String longitude;
  final String phone_number;
  final String parking_available;
  final String facility_status;
  final String accessibility_info;
  final String opening_hours;
  final String court_description;
  final double rating;

//<editor-fold desc="Data Methods">
  const CourtModel({
    required this.court_id,
    required this.court_type,
    required this.court_type_detail,
    required this.court_name,
    required this.city_code,
    required this.district_code,
    required this.postal_code,
    required this.road_address,
    required this.address_code,
    required this.latitude,
    required this.longitude,
    required this.phone_number,
    required this.parking_available,
    required this.facility_status,
    required this.accessibility_info,
    required this.opening_hours,
    required this.court_description,
    required this.rating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourtModel &&
          runtimeType == other.runtimeType &&
          court_id == other.court_id &&
          court_type == other.court_type &&
          court_type_detail == other.court_type_detail &&
          court_name == other.court_name &&
          city_code == other.city_code &&
          district_code == other.district_code &&
          postal_code == other.postal_code &&
          road_address == other.road_address &&
          address_code == other.address_code &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          phone_number == other.phone_number &&
          parking_available == other.parking_available &&
          facility_status == other.facility_status &&
          accessibility_info == other.accessibility_info &&
          opening_hours == other.opening_hours &&
          court_description == other.court_description &&
          rating == other.rating);

  @override
  int get hashCode =>
      court_id.hashCode ^
      court_type.hashCode ^
      court_type_detail.hashCode ^
      court_name.hashCode ^
      city_code.hashCode ^
      district_code.hashCode ^
      postal_code.hashCode ^
      road_address.hashCode ^
      address_code.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      phone_number.hashCode ^
      parking_available.hashCode ^
      facility_status.hashCode ^
      accessibility_info.hashCode ^
      opening_hours.hashCode ^
      court_description.hashCode ^
      rating.hashCode;

  @override
  String toString() {
    return 'CourtModel{' +
        ' court_id: $court_id,' +
        ' court_type: $court_type,' +
        ' court_type_detail: $court_type_detail,' +
        ' court_name: $court_name,' +
        ' city_code: $city_code,' +
        ' district_code: $district_code,' +
        ' postal_code: $postal_code,' +
        ' road_address: $road_address,' +
        ' address_code: $address_code,' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        ' phone_number: $phone_number,' +
        ' parking_available: $parking_available,' +
        ' facility_status: $facility_status,' +
        ' accessibility_info: $accessibility_info,' +
        ' opening_hours: $opening_hours,' +
        ' court_description: $court_description,' +
        ' rating: $rating,' +
        '}';
  }

  CourtModel copyWith({
    int? court_id,
    String? court_type,
    String? court_type_detail,
    String? court_name,
    String? city_code,
    String? district_code,
    String? postal_code,
    String? road_address,
    String? address_code,
    String? latitude,
    String? longitude,
    String? phone_number,
    String? parking_available,
    String? facility_status,
    String? accessibility_info,
    String? opening_hours,
    String? court_description,
    double? rating,
  }) {
    return CourtModel(
      court_id: court_id ?? this.court_id,
      court_type: court_type ?? this.court_type,
      court_type_detail: court_type_detail ?? this.court_type_detail,
      court_name: court_name ?? this.court_name,
      city_code: city_code ?? this.city_code,
      district_code: district_code ?? this.district_code,
      postal_code: postal_code ?? this.postal_code,
      road_address: road_address ?? this.road_address,
      address_code: address_code ?? this.address_code,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone_number: phone_number ?? this.phone_number,
      parking_available: parking_available ?? this.parking_available,
      facility_status: facility_status ?? this.facility_status,
      accessibility_info: accessibility_info ?? this.accessibility_info,
      opening_hours: opening_hours ?? this.opening_hours,
      court_description: court_description ?? this.court_description,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'court_id': this.court_id,
      'court_type': this.court_type,
      'court_type_detail': this.court_type_detail,
      'court_name': this.court_name,
      'city_code': this.city_code,
      'district_code': this.district_code,
      'postal_code': this.postal_code,
      'road_address': this.road_address,
      'address_code': this.address_code,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'phone_number': this.phone_number,
      'parking_available': this.parking_available,
      'facility_status': this.facility_status,
      'accessibility_info': this.accessibility_info,
      'opening_hours': this.opening_hours,
      'court_description': this.court_description,
      'rating': this.rating,
    };
  }

  factory CourtModel.fromMap(Map<String, dynamic> map) {
    return CourtModel(
      court_id: map['court_id'] as int? ?? 0,
      court_type: map['court_type'] as String? ?? '',
      court_type_detail: map['court_type_detail'] as String? ?? '',
      court_name: map['court_name'] as String? ?? '',
      city_code: map['city_code'] as String? ?? '',
      district_code: map['district_code'] as String? ?? '',
      postal_code: map['postal_code'] as String? ?? '',
      road_address: map['road_address'] as String? ?? '',
      address_code: map['address_code'] as String? ?? '',
      latitude: map['latitude'] as String? ?? '',
      longitude: map['longitude'] as String? ?? '',
      phone_number: map['phone_number'] as String? ?? '',
      parking_available: map['parking_available'] as String? ?? '',
      facility_status: map['facility_status'] as String? ?? '',
      accessibility_info: map['accessibility_info'] as String? ?? '',
      opening_hours: map['opening_hours'] as String? ?? '',
      court_description: map['court_description'] as String? ?? '',
      rating: map['rating'] as double? ?? 0.0,
    );
  }

//</editor-fold>
}

class MatchModel {
  final int match_id;
  final String match_type;
  final String match_date;
  final String start_time; // 'HH:mm' 형식의 시간
  final String end_time;
  final int court_id;
  final String court_name;
  final int organizer_id;
  final String match_status;

//<editor-fold desc="Data Methods">
  const MatchModel({
    required this.match_id,
    required this.match_type,
    required this.match_date,
    required this.start_time,
    required this.end_time,
    required this.court_id,
    required this.court_name,
    required this.organizer_id,
    required this.match_status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchModel &&
          runtimeType == other.runtimeType &&
          match_id == other.match_id &&
          match_type == other.match_type &&
          match_date == other.match_date &&
          start_time == other.start_time &&
          end_time == other.end_time &&
          court_id == other.court_id &&
          court_name == other.court_name &&
          organizer_id == other.organizer_id &&
          match_status == other.match_status);

  @override
  int get hashCode =>
      match_id.hashCode ^
      match_type.hashCode ^
      match_date.hashCode ^
      start_time.hashCode ^
      end_time.hashCode ^
      court_id.hashCode ^
      court_name.hashCode ^
      organizer_id.hashCode ^
      match_status.hashCode;

  @override
  String toString() {
    return 'MatchModel{' +
        ' match_id: $match_id,' +
        ' match_type: $match_type,' +
        ' match_date: $match_date,' +
        ' start_time: $start_time,' +
        ' end_time: $end_time,' +
        ' court_id: $court_id,' +
        ' court_name: $court_name,' +
        ' organizer_id: $organizer_id,' +
        ' match_status: $match_status,' +
        '}';
  }

  MatchModel copyWith({
    int? match_id,
    String? match_type,
    String? match_date,
    String? start_time,
    String? end_time,
    int? court_id,
    String? court_name,
    int? organizer_id,
    String? match_status,
  }) {
    return MatchModel(
      match_id: match_id ?? this.match_id,
      match_type: match_type ?? this.match_type,
      match_date: match_date ?? this.match_date,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
      court_id: court_id ?? this.court_id,
      court_name: court_name ?? this.court_name,
      organizer_id: organizer_id ?? this.organizer_id,
      match_status: match_status ?? this.match_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'match_id': this.match_id,
      'match_type': this.match_type,
      'match_date': this.match_date,
      'start_time': this.start_time,
      'end_time': this.end_time,
      'court_id': this.court_id,
      'court_name': this.court_name,
      'organizer_id': this.organizer_id,
      'match_status': this.match_status,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      match_id: map['match_id'] as int,
      match_type: map['match_type'] as String,
      match_date: map['match_date'] as String,
      start_time: map['start_time'] as String,
      end_time: map['end_time'] as String,
      court_id: map['court_id'] as int,
      court_name: map['court_name'] as String,
      organizer_id: map['organizer_id'] as int,
      match_status: map['match_status'] as String,
    );
  }

//</editor-fold>
}

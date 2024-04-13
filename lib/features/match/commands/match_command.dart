class MatchCommand {
  final int match_id;
  final String match_type;
  final String match_date;
  final String start_time; // 'HH:mm' 형식의 시간
  final String end_time;
  final int court_id;
  final int organizer_id;
  final String status;

//<editor-fold desc="Data Methods">
  const MatchCommand({
    required this.match_id,
    required this.match_type,
    required this.match_date,
    required this.start_time,
    required this.end_time,
    required this.court_id,
    required this.organizer_id,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchCommand &&
          runtimeType == other.runtimeType &&
          match_id == other.match_id &&
          match_type == other.match_type &&
          match_date == other.match_date &&
          start_time == other.start_time &&
          end_time == other.end_time &&
          court_id == other.court_id &&
          organizer_id == other.organizer_id &&
          status == other.status);

  @override
  int get hashCode =>
      match_id.hashCode ^
      match_type.hashCode ^
      match_date.hashCode ^
      start_time.hashCode ^
      end_time.hashCode ^
      court_id.hashCode ^
      organizer_id.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'MatchCommand{' +
        ' match_id: $match_id,' +
        ' match_type: $match_type,' +
        ' match_date: $match_date,' +
        ' start_time: $start_time,' +
        ' end_time: $end_time,' +
        ' court_id: $court_id,' +
        ' organizer_id: $organizer_id,' +
        ' status: $status,' +
        '}';
  }

  MatchCommand copyWith({
    int? match_id,
    String? match_type,
    String? match_date,
    String? start_time,
    String? end_time,
    int? court_id,
    int? organizer_id,
    String? status,
  }) {
    return MatchCommand(
      match_id: match_id ?? this.match_id,
      match_type: match_type ?? this.match_type,
      match_date: match_date ?? this.match_date,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
      court_id: court_id ?? this.court_id,
      organizer_id: organizer_id ?? this.organizer_id,
      status: status ?? this.status,
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
      'organizer_id': this.organizer_id,
      'status': this.status,
    };
  }

  factory MatchCommand.fromMap(Map<String, dynamic> map) {
    return MatchCommand(
      match_id: map['match_id'] as int,
      match_type: map['match_type'] as String,
      match_date: map['match_date'] as String,
      start_time: map['start_time'] as String,
      end_time: map['end_time'] as String,
      court_id: map['court_id'] as int,
      organizer_id: map['organizer_id'] as int,
      status: map['status'] as String,
    );
  }

//</editor-fold>
}

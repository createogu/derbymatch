class TeamScheduleInfoModel {
  final int team_id;
  final int seq;
  final int court_id;
  final String court_name;
  final String day_of_week;
  final String start_time; // 'HH:mm' 형식의 시간
  final String end_time;

//<editor-fold desc="Data Methods">

  const TeamScheduleInfoModel({
    required this.team_id,
    required this.seq,
    required this.court_id,
    required this.court_name,
    required this.day_of_week,
    required this.start_time,
    required this.end_time,
  });

// 'H@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamScheduleInfoModel &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          seq == other.seq &&
          court_id == other.court_id &&
          court_name == other.court_name &&
          day_of_week == other.day_of_week &&
          start_time == other.start_time &&
          end_time == other.end_time);

  @override
  int get hashCode =>
      team_id.hashCode ^
      seq.hashCode ^
      court_id.hashCode ^
      court_name.hashCode ^
      day_of_week.hashCode ^
      start_time.hashCode ^
      end_time.hashCode;

  @override
  String toString() {
    return 'TeamScheduleInfoModel{' +
        ' team_id: $team_id,' +
        ' seq: $seq,' +
        ' court_id: $court_id,' +
        ' court_name: $court_name,' +
        ' day_of_week: $day_of_week,' +
        ' start_time: $start_time,' +
        ' end_time: $end_time,' +
        '}';
  }

  TeamScheduleInfoModel copyWith({
    int? team_id,
    int? seq,
    int? court_id,
    String? court_name,
    String? day_of_week,
    String? start_time,
    String? end_time,
  }) {
    return TeamScheduleInfoModel(
      team_id: team_id ?? this.team_id,
      seq: seq ?? this.seq,
      court_id: court_id ?? this.court_id,
      court_name: court_name ?? this.court_name,
      day_of_week: day_of_week ?? this.day_of_week,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'seq': this.seq,
      'court_id': this.court_id,
      'court_name': this.court_name,
      'day_of_week': this.day_of_week,
      'start_time': this.start_time,
      'end_time': this.end_time,
    };
  }

  factory TeamScheduleInfoModel.fromMap(Map<String, dynamic> map) {
    String formatTime(String? time) {
      if (time != null && time.length >= 5) {
        return time.substring(0, 5);
      }
      return "00:00"; // 또는 기본값
    }

    return TeamScheduleInfoModel(
      team_id: map['team_id'] as int,
      seq: map['seq'] as int,
      court_id: map['court_id'] as int,
      court_name: map['court_name'] as String,
      day_of_week: map['day_of_week'] as String,
      start_time: formatTime(map['start_time'] as String?),
      end_time: formatTime(map['end_time'] as String?),
    );
  }

//</editor-fold>
}

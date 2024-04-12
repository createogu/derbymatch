class TeamScheduleInfoCommand {
  final int team_id;
  final int court_id;
  final String day_of_week;
  final String start_time; // 'HH:mm' 형식의 시간
  final String end_time;

//<editor-fold desc="Data Methods">
  const TeamScheduleInfoCommand({
    required this.team_id,
    required this.court_id,
    required this.day_of_week,
    required this.start_time,
    required this.end_time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamScheduleInfoCommand &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          court_id == other.court_id &&
          day_of_week == other.day_of_week &&
          start_time == other.start_time &&
          end_time == other.end_time);

  @override
  int get hashCode =>
      team_id.hashCode ^
      court_id.hashCode ^
      day_of_week.hashCode ^
      start_time.hashCode ^
      end_time.hashCode;

  @override
  String toString() {
    return 'TeamScheduleInfoCommand{' +
        ' team_id: $team_id,' +
        ' court_id: $court_id,' +
        ' day_of_week: $day_of_week,' +
        ' start_time: $start_time,' +
        ' end_time: $end_time,' +
        '}';
  }

  TeamScheduleInfoCommand copyWith({
    int? team_id,
    int? court_id,
    String? day_of_week,
    String? start_time,
    String? end_time,
  }) {
    return TeamScheduleInfoCommand(
      team_id: team_id ?? this.team_id,
      court_id: court_id ?? this.court_id,
      day_of_week: day_of_week ?? this.day_of_week,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'court_id': this.court_id,
      'day_of_week': this.day_of_week,
      'start_time': this.start_time,
      'end_time': this.end_time,
    };
  }

  factory TeamScheduleInfoCommand.fromMap(Map<String, dynamic> map) {
    return TeamScheduleInfoCommand(
      team_id: map['team_id'] as int,
      court_id: map['court_id'] as int,
      day_of_week: map['day_of_week'] as String,
      start_time: map['start_time'] as String,
      end_time: map['end_time'] as String,
    );
  }

//</editor-fold>
}

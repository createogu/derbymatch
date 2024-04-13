class MatchParticipantModel {
  final int match_id;
  final int user_id;
  final int team_id;
  final String status;

//<editor-fold desc="Data Methods">
  const MatchParticipantModel({
    required this.match_id,
    required this.user_id,
    required this.team_id,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchParticipantModel &&
          runtimeType == other.runtimeType &&
          match_id == other.match_id &&
          user_id == other.user_id &&
          team_id == other.team_id &&
          status == other.status);

  @override
  int get hashCode =>
      match_id.hashCode ^ user_id.hashCode ^ team_id.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'MatchParticipantModel{' +
        ' match_id: $match_id,' +
        ' user_id: $user_id,' +
        ' team_id: $team_id,' +
        ' status: $status,' +
        '}';
  }

  MatchParticipantModel copyWith({
    int? match_id,
    int? user_id,
    int? team_id,
    String? status,
  }) {
    return MatchParticipantModel(
      match_id: match_id ?? this.match_id,
      user_id: user_id ?? this.user_id,
      team_id: team_id ?? this.team_id,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'match_id': this.match_id,
      'user_id': this.user_id,
      'team_id': this.team_id,
      'status': this.status,
    };
  }

  factory MatchParticipantModel.fromMap(Map<String, dynamic> map) {
    return MatchParticipantModel(
      match_id: map['match_id'] as int,
      user_id: map['user_id'] as int,
      team_id: map['team_id'] as int,
      status: map['status'] as String,
    );
  }

//</editor-fold>
}

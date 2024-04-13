class MatchFilterCommand {
  final String match_type;

//<editor-fold desc="Data Methods">
  const MatchFilterCommand({
    required this.match_type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchFilterCommand &&
          runtimeType == other.runtimeType &&
          match_type == other.match_type);

  @override
  int get hashCode => match_type.hashCode;

  @override
  String toString() {
    return 'MatchFilterCommand{' + ' match_type: $match_type,' + '}';
  }

  MatchFilterCommand copyWith({
    String? match_type,
  }) {
    return MatchFilterCommand(
      match_type: match_type ?? this.match_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'match_type': this.match_type,
    };
  }

  factory MatchFilterCommand.fromMap(Map<String, dynamic> map) {
    return MatchFilterCommand(
      match_type: map['match_type'] as String,
    );
  }

//</editor-fold>
}

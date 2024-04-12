class TeamPhotoCommand {
  final int team_id;
  final List<String> image_path;

//<editor-fold desc="Data Methods">
  const TeamPhotoCommand({
    required this.team_id,
    required this.image_path,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPhotoCommand &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          image_path == other.image_path);

  @override
  int get hashCode => team_id.hashCode ^ image_path.hashCode;

  @override
  String toString() {
    return 'TeamPhotoCommand{' +
        ' team_id: $team_id,' +
        ' image_path: $image_path,' +
        '}';
  }

  TeamPhotoCommand copyWith({
    int? team_id,
    List<String>? image_path,
  }) {
    return TeamPhotoCommand(
      team_id: team_id ?? this.team_id,
      image_path: image_path ?? this.image_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'image_path': this.image_path,
    };
  }

  factory TeamPhotoCommand.fromMap(Map<String, dynamic> map) {
    return TeamPhotoCommand(
      team_id: map['team_id'] as int,
      image_path: map['image_path'] as List<String>,
    );
  }

//</editor-fold>
}

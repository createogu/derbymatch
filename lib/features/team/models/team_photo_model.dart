class TeamPhotoModel {
  final int team_id;
  final int seq;
  final String image_path;

//<editor-fold desc="Data Methods">
  const TeamPhotoModel({
    required this.team_id,
    required this.seq,
    required this.image_path,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPhotoModel &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          seq == other.seq &&
          image_path == other.image_path);

  @override
  int get hashCode => team_id.hashCode ^ seq.hashCode ^ image_path.hashCode;

  @override
  String toString() {
    return 'TeamPhotoModel{' +
        ' team_id: $team_id,' +
        ' seq: $seq,' +
        ' image_path: $image_path,' +
        '}';
  }

  TeamPhotoModel copyWith({
    int? team_id,
    int? seq,
    String? image_path,
  }) {
    return TeamPhotoModel(
      team_id: team_id ?? this.team_id,
      seq: seq ?? this.seq,
      image_path: image_path ?? this.image_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'seq': this.seq,
      'image_path': this.image_path,
    };
  }

  factory TeamPhotoModel.fromMap(Map<String, dynamic> map) {
    return TeamPhotoModel(
      team_id: map['team_id'] as int,
      seq: map['seq'] as int,
      image_path: map['image_path'] as String,
    );
  }

//</editor-fold>
}

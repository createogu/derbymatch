class TeamModel {
  final int team_id;
  final String name;
  final String team_logo_image;
  final int since_year;
  final String division;
  final String addressCode;
  final String addressName;
  final String introduce;

//<editor-fold desc="Data Methods">
  const TeamModel({
    required this.team_id,
    required this.name,
    required this.team_logo_image,
    required this.since_year,
    required this.division,
    required this.addressCode,
    required this.addressName,
    required this.introduce,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamModel &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          name == other.name &&
          team_logo_image == other.team_logo_image &&
          since_year == other.since_year &&
          division == other.division &&
          addressCode == other.addressCode &&
          addressName == other.addressName &&
          introduce == other.introduce);

  @override
  int get hashCode =>
      team_id.hashCode ^
      name.hashCode ^
      team_logo_image.hashCode ^
      since_year.hashCode ^
      division.hashCode ^
      addressCode.hashCode ^
      addressName.hashCode ^
      introduce.hashCode;

  @override
  String toString() {
    return 'TeamModel{' +
        ' team_id: $team_id,' +
        ' name: $name,' +
        ' team_logo_image: $team_logo_image,' +
        ' since_year: $since_year,' +
        ' division: $division,' +
        ' addressCode: $addressCode,' +
        ' addressName: $addressName,' +
        ' introduce: $introduce,' +
        '}';
  }

  TeamModel copyWith({
    int? team_id,
    String? name,
    String? team_logo_image,
    int? since_year,
    String? division,
    String? addressCode,
    String? addressName,
    String? introduce,
  }) {
    return TeamModel(
      team_id: team_id ?? this.team_id,
      name: name ?? this.name,
      team_logo_image: team_logo_image ?? this.team_logo_image,
      since_year: since_year ?? this.since_year,
      division: division ?? this.division,
      addressCode: addressCode ?? this.addressCode,
      addressName: addressName ?? this.addressName,
      introduce: introduce ?? this.introduce,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'name': this.name,
      'team_logo_image': this.team_logo_image,
      'since_year': this.since_year,
      'division': this.division,
      'addressCode': this.addressCode,
      'addressName': this.addressName,
      'introduce': this.introduce,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      team_id: map['team_id'] as int,
      name: map['name'] as String,
      team_logo_image: map['team_logo_image'] as String,
      since_year: map['since_year'] as int,
      division: map['division'] as String,
      addressCode: map['addressCode'] as String,
      addressName: map['addressName'] as String,
      introduce: map['introduce'] as String,
    );
  }

//</editor-fold>
}

import 'package:derbymatch/features/player/models/player_model.dart';

class TeamMemberModel {
  final int team_id;
  final int user_id;
  final String profile_image;
  final String name;
  final String gender_cd;
  final String gender_nm;
  final String division_cd;
  final String division_nm;
  final List<String> positions;
  final String addressCode;
  final String addressName;
  final String introduce;
  final double height;
  final double weight;
  final int player_number;
  final String role;

//<editor-fold desc="Data Methods">
  const TeamMemberModel({
    required this.team_id,
    required this.user_id,
    required this.profile_image,
    required this.name,
    required this.gender_cd,
    required this.gender_nm,
    required this.division_cd,
    required this.division_nm,
    required this.positions,
    required this.addressCode,
    required this.addressName,
    required this.introduce,
    required this.height,
    required this.weight,
    required this.player_number,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamMemberModel &&
          runtimeType == other.runtimeType &&
          team_id == other.team_id &&
          user_id == other.user_id &&
          profile_image == other.profile_image &&
          name == other.name &&
          gender_cd == other.gender_cd &&
          gender_nm == other.gender_nm &&
          division_cd == other.division_cd &&
          division_nm == other.division_nm &&
          positions == other.positions &&
          addressCode == other.addressCode &&
          addressName == other.addressName &&
          introduce == other.introduce &&
          height == other.height &&
          weight == other.weight &&
          player_number == other.player_number &&
          role == other.role);

  @override
  int get hashCode =>
      team_id.hashCode ^
      user_id.hashCode ^
      profile_image.hashCode ^
      name.hashCode ^
      gender_cd.hashCode ^
      gender_nm.hashCode ^
      division_cd.hashCode ^
      division_nm.hashCode ^
      positions.hashCode ^
      addressCode.hashCode ^
      addressName.hashCode ^
      introduce.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      player_number.hashCode ^
      role.hashCode;

  @override
  String toString() {
    return 'TeamMemberModel{' +
        ' team_id: $team_id,' +
        ' user_id: $user_id,' +
        ' profile_image: $profile_image,' +
        ' name: $name,' +
        ' gender_cd: $gender_cd,' +
        ' gender_nm: $gender_nm,' +
        ' division_cd: $division_cd,' +
        ' division_nm: $division_nm,' +
        ' positions: $positions,' +
        ' addressCode: $addressCode,' +
        ' addressName: $addressName,' +
        ' introduce: $introduce,' +
        ' height: $height,' +
        ' weight: $weight,' +
        ' player_number: $player_number,' +
        ' role: $role,' +
        '}';
  }

  TeamMemberModel copyWith({
    int? team_id,
    int? user_id,
    String? profile_image,
    String? name,
    String? gender_cd,
    String? gender_nm,
    String? division_cd,
    String? division_nm,
    List<String>? positions,
    String? addressCode,
    String? addressName,
    String? introduce,
    double? height,
    double? weight,
    int? player_number,
    String? role,
  }) {
    return TeamMemberModel(
      team_id: team_id ?? this.team_id,
      user_id: user_id ?? this.user_id,
      profile_image: profile_image ?? this.profile_image,
      name: name ?? this.name,
      gender_cd: gender_cd ?? this.gender_cd,
      gender_nm: gender_nm ?? this.gender_nm,
      division_cd: division_cd ?? this.division_cd,
      division_nm: division_nm ?? this.division_nm,
      positions: positions ?? this.positions,
      addressCode: addressCode ?? this.addressCode,
      addressName: addressName ?? this.addressName,
      introduce: introduce ?? this.introduce,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      player_number: player_number ?? this.player_number,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_id': this.team_id,
      'user_id': this.user_id,
      'profile_image': this.profile_image,
      'name': this.name,
      'gender_cd': this.gender_cd,
      'gender_nm': this.gender_nm,
      'division_cd': this.division_cd,
      'division_nm': this.division_nm,
      'positions': this.positions,
      'addressCode': this.addressCode,
      'addressName': this.addressName,
      'introduce': this.introduce,
      'height': this.height,
      'weight': this.weight,
      'player_number': this.player_number,
      'role': this.role,
    };
  }

  factory TeamMemberModel.fromMap(Map<String, dynamic> map) {
    return TeamMemberModel(
      team_id: map['team_id'] as int,
      user_id: map['user_id'] as int,
      profile_image: map['profile_image'] == null ? '' : map['profile_image'],
      name: map['name'] == null ? '' : map['name'],
      division_cd: map['division_cd'] == null ? '04' : map['division_cd'],
      division_nm: map['division_nm'] == null ? '일반부' : map['division_nm'],
      gender_cd: map['gender_cd'] == null ? '01' : map['gender_cd'],
      gender_nm: map['gender_nm'] == null ? '남자' : map['gender_nm'],
      positions:
          map['positions'] == null ? [] : List<String>.from(map['positions']),
      addressCode: map['addressCode'] == null ? '' : map['addressCode'],
      addressName: map['addressName'] == null ? '' : map['addressName'],
      introduce: map['introduce'] == null ? '' : map['introduce'],
      height: map['height'] == null ? 170 : map['height'],
      weight: map['weight'] == null ? 70 : map['weight'],
      player_number: map['player_number'] as int,
      role: map['role'] as String,
    );
  }

//</editor-fold>
}

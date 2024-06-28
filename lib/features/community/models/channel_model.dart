class ChannelModel {
  final int channel_id;
  final String channel_name;
  final String channel_type;
  final int team_id;
  final String adderess_code;
  final String use_yn;

//<editor-fold desc="Data Methods">
  const ChannelModel({
    required this.channel_id,
    required this.channel_name,
    required this.channel_type,
    required this.team_id,
    required this.adderess_code,
    required this.use_yn,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelModel &&
          runtimeType == other.runtimeType &&
          channel_id == other.channel_id &&
          channel_name == other.channel_name &&
          channel_type == other.channel_type &&
          team_id == other.team_id &&
          adderess_code == other.adderess_code &&
          use_yn == other.use_yn);

  @override
  int get hashCode =>
      channel_id.hashCode ^
      channel_name.hashCode ^
      channel_type.hashCode ^
      team_id.hashCode ^
      adderess_code.hashCode ^
      use_yn.hashCode;

  @override
  String toString() {
    return 'ChannelModel{' +
        ' channel_id: $channel_id,' +
        ' channel_name: $channel_name,' +
        ' channel_type: $channel_type,' +
        ' team_id: $team_id,' +
        ' adderess_code: $adderess_code,' +
        ' use_yn: $use_yn,' +
        '}';
  }

  ChannelModel copyWith({
    int? channel_id,
    String? channel_name,
    String? channel_type,
    int? team_id,
    String? adderess_code,
    String? use_yn,
  }) {
    return ChannelModel(
      channel_id: channel_id ?? this.channel_id,
      channel_name: channel_name ?? this.channel_name,
      channel_type: channel_type ?? this.channel_type,
      team_id: team_id ?? this.team_id,
      adderess_code: adderess_code ?? this.adderess_code,
      use_yn: use_yn ?? this.use_yn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'channel_id': this.channel_id,
      'channel_name': this.channel_name,
      'channel_type': this.channel_type,
      'team_id': this.team_id,
      'adderess_code': this.adderess_code,
      'use_yn': this.use_yn,
    };
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      channel_id: map['channel_id'] as int,
      channel_name: map['channel_name'] as String,
      channel_type: map['channel_type'] as String,
      team_id: map['team_id'] as int,
      adderess_code: map['adderess_code'] ?? '' as String,
      use_yn: map['use_yn'] as String,
    );
  }

//</editor-fold>
}

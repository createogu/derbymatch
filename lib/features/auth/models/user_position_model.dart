import 'package:flutter/foundation.dart';

class UserPositionModel {
  final int user_id;
  final String position_cd;

//<editor-fold desc="Data Methods">
  const UserPositionModel({
    required this.user_id,
    required this.position_cd,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPositionModel &&
          runtimeType == other.runtimeType &&
          user_id == other.user_id &&
          position_cd == other.position_cd);

  @override
  int get hashCode => user_id.hashCode ^ position_cd.hashCode;

  @override
  String toString() {
    return 'UserPositionModel{' +
        ' user_id: $user_id,' +
        ' position_cd: $position_cd,' +
        '}';
  }

  UserPositionModel copyWith({
    int? user_id,
    String? position_cd,
  }) {
    return UserPositionModel(
      user_id: user_id ?? this.user_id,
      position_cd: position_cd ?? this.position_cd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': this.user_id,
      'position_cd': this.position_cd,
    };
  }

  factory UserPositionModel.fromMap(Map<String, dynamic> map) {
    return UserPositionModel(
      user_id: map['user_id'] as int,
      position_cd: map['position_cd'] as String,
    );
  }

//</editor-fold>
}

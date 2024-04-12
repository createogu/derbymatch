import 'package:flutter/foundation.dart';

abstract class UserModelBase {}

class UserModelLoading extends UserModelBase {}

class UserModelError extends UserModelBase {
  final String errorMessage;

  UserModelError({
    required this.errorMessage,
  });
}

class UserModel extends UserModelBase {
  final int user_id;
  final String provider;
  final String provider_id;
  final String profile_image;
  final String name;
  final String gender;
  final String division;
  final List<String> positions;
  final String addressCode;
  final String addressName;
  final String introduce;
  final double height;
  final double weight;
  final String email;
  final String refreshToken;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.user_id,
    required this.provider,
    required this.provider_id,
    required this.profile_image,
    required this.name,
    required this.gender,
    required this.division,
    required this.positions,
    required this.addressCode,
    required this.addressName,
    required this.introduce,
    required this.height,
    required this.weight,
    required this.email,
    required this.refreshToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          user_id == other.user_id &&
          provider == other.provider &&
          provider_id == other.provider_id &&
          profile_image == other.profile_image &&
          name == other.name &&
          gender == other.gender &&
          division == other.division &&
          listEquals(other.positions, positions) &&
          addressCode == other.addressCode &&
          addressName == other.addressName &&
          introduce == other.introduce &&
          height == other.height &&
          weight == other.weight &&
          email == other.email &&
          refreshToken == other.refreshToken);

  @override
  int get hashCode =>
      user_id.hashCode ^
      provider.hashCode ^
      provider_id.hashCode ^
      profile_image.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      division.hashCode ^
      positions.hashCode ^
      addressCode.hashCode ^
      addressName.hashCode ^
      introduce.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      email.hashCode ^
      refreshToken.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' user_id: $user_id,' +
        ' provider: $provider,' +
        ' provider_id: $provider_id,' +
        ' profile_image: $profile_image,' +
        ' name: $name,' +
        ' gender: $gender,' +
        ' division: $division,' +
        ' positions: $positions,' +
        ' addressCode: $addressCode,' +
        ' addressName: $addressName,' +
        ' introduce: $introduce,' +
        ' height: $height,' +
        ' weight: $weight,' +
        ' email: $email,' +
        ' refreshToken: $refreshToken,' +
        '}';
  }

  UserModel copyWith({
    int? user_id,
    String? provider,
    String? provider_id,
    String? profile_image,
    String? name,
    String? gender,
    String? division,
    List<String>? positions,
    String? addressCode,
    String? addressName,
    String? introduce,
    double? height,
    double? weight,
    String? email,
    String? refreshToken,
  }) {
    return UserModel(
      user_id: user_id ?? this.user_id,
      provider: provider ?? this.provider,
      provider_id: provider_id ?? this.provider_id,
      profile_image: profile_image ?? this.profile_image,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      division: division ?? this.division,
      positions: positions ?? this.positions,
      addressCode: addressCode ?? this.addressCode,
      addressName: addressName ?? this.addressName,
      introduce: introduce ?? this.introduce,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': this.user_id,
      'provider': this.provider,
      'provider_id': this.provider_id,
      'profile_image': this.profile_image,
      'name': this.name,
      'gender': this.gender,
      'division': this.division,
      'positions': this.positions,
      'addressCode': this.addressCode,
      'addressName': this.addressName,
      'introduce': this.introduce,
      'height': this.height,
      'weight': this.weight,
      'email': this.email,
      'refreshToken': this.refreshToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] as int,
      provider: map['provider'],
      provider_id: map['provider_id'],
      profile_image: map['profile_image'] == null ? '' : map['profile_image'],
      name: map['name'] == null ? '' : map['name'],
      division: map['division'] == null ? '04' : map['division'],
      gender: map['gender'] == null ? '01' : map['gender'],
      positions:
          map['positions'] == null ? [] : List<String>.from(map['positions']),
      addressCode: map['addressCode'] == null ? '' : map['addressCode'],
      addressName: map['addressName'] == null ? '' : map['addressName'],
      introduce: map['introduce'] == null ? '' : map['introduce'],
      height: map['height'] == null ? 170 : map['height'],
      weight: map['weight'] == null ? 70 : map['weight'],
      email: map['email'],
      refreshToken: map['refreshToken'],
    );
  }

//</editor-fold>
}

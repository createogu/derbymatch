class TokenResponseModel {
  final String accessToken;

//<editor-fold desc="Data Methods">
  const TokenResponseModel({
    required this.accessToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TokenResponseModel &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken);

  @override
  int get hashCode => accessToken.hashCode;

  @override
  String toString() {
    return 'TokenResponseModel{' + ' accessToken: $accessToken,' + '}';
  }

  TokenResponseModel copyWith({
    String? accessToken,
  }) {
    return TokenResponseModel(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': this.accessToken,
    };
  }

  factory TokenResponseModel.fromMap(Map<String, dynamic> map) {
    return TokenResponseModel(
      accessToken: map['accessToken'] as String,
    );
  }

//</editor-fold>
}

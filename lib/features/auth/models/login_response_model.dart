class LoginResponseModel {
  final String refreshToken;
  final String accessToken;

//<editor-fold desc="Data Methods">
  const LoginResponseModel({
    required this.refreshToken,
    required this.accessToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginResponseModel &&
          runtimeType == other.runtimeType &&
          refreshToken == other.refreshToken &&
          accessToken == other.accessToken);

  @override
  int get hashCode => refreshToken.hashCode ^ accessToken.hashCode;

  @override
  String toString() {
    return 'LoginResponseModel{' +
        ' refreshToken: $refreshToken,' +
        ' accessToken: $accessToken,' +
        '}';
  }

  LoginResponseModel copyWith({
    String? refreshToken,
    String? accessToken,
  }) {
    return LoginResponseModel(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'refreshToken': this.refreshToken,
      'accessToken': this.accessToken,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
    );
  }

//</editor-fold>
}
